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
      f.input :project, selected: params[:project_id].nil? ? f.object.project_id : params[:project_id]
      f.input :amount
      f.input :stock_state
    end
    f.actions
  end

  controller do
    def create
      contrepartie = Contrepartie.new(contrepartie_params)
      transaction = CreateContrepartie.new.call(contrepartie: contrepartie)
      if transaction.success?
        redirect_to admin_contreparty_path(contrepartie.id)
      else
        @contrepartie = transaction.failure[:resource]
        render :new
      end
    end

    private

    def contrepartie_params
      params.require(:contrepartie).permit(:project_id, :name, :amount, :stock_state)
    end
  end
end
