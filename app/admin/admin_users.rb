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
      if f.object.new_record?
        f.input :email
      end
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
