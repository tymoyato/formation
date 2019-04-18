ActiveAdmin.register Contribution do
  permit_params :amount, :user_id, :project_id

  form do |f|
    f.inputs do
      f.input :user,
                collection: User.all.map { |u| ["#{u.first_name} #{u.last_name}", u.id] }
      f.input :project
      f.input :amount
    end
    f.actions
  end
end
