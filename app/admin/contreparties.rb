ActiveAdmin.register Contrepartie do
  permit_params :project_id, :name, :amount, :stock_state
end