ActiveAdmin.register Contrepartie do
  permit_params :project_id, :name, :amount, :stock_state

  form do |f|
    f.inputs do
      f.input :name
      f.input :project, selected: params[:id]
      f.input :amount
      f.input :stock_state
    end
    f.actions
  end
end
