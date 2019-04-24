ActiveAdmin.register Contribution do
  permit_params :amount, :user_id, :project_id, :contrepartie_id

  form do |f|
    f.inputs do
      f.input :user,
                collection: User.all.map { |u| ["#{u.first_name} #{u.last_name}", u.id] }
      f.input :project
      f.input :amount
      f.input :contrepartie
    end
    f.actions
  end

  controller do
    def create
      contribution = build_resource
      transaction = CreateContribution.new.call(contribution: contribution)
      if transaction.success?
        contribution.project.update_attributes(percentage: contribution.project.percentage_of_completion)
        redirect_to admin_contribution_path(contribution.id)
      else
        resource.contribution = transaction.failure[:resource]
        render :new
      end
    end
  end
end
