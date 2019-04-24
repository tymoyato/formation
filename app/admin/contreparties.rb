ActiveAdmin.register Contrepartie do
  permit_params :project_id, :name, :amount, :stock_state

  index do
    selectable_column
    id_column
    column :name
    column :project
    column :amount
    column :stock_state
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :project, selected: params[:id]
      f.input :amount
      f.input :stock_state
    end
    f.actions
  end

  controller do
    def create
      contrepartie = build_resource
      transaction = CreateContrepartie.new.call(contrepartie: contrepartie)
      if transaction.success?
        redirect_to admin_contreparty_path(contrepartie.id)
      else
        resource.contrepartie = transaction.failure[:resource]
        render :new
      end
    end
  end
end
