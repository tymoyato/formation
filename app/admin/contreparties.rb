ActiveAdmin.register Contrepartie do
  permit_params :project_id, :name, :amount, :stock_state

  form do |f|
    f.inputs do
      f.input :name
      f.input :project, selected: params[:project_id].nil? ? f.object.project_id : params[:project_id]
      f.input :amount
      f.input :stock_state
    end
    f.actions
  end
end
