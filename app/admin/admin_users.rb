ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :created_at

  form do |f|
    f.inputs do
      if !f.object.new_record?
        f.input :password
        f.input :password_confirmation
      else
        f.input :email
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end
end
