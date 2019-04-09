ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation,
                :first_name, :last_name, :date_of_birth

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :last_sign_in_at
    column :current_sign_in_ip
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :last_sign_in_at

  form do |f|
    f.inputs do
      if !f.object.new_record?
        f.input :email
        f.input :first_name
        f.input :last_name
      else
        f.input :email
        f.input :first_name
        f.input :last_name
        f.input :date_of_birth
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end

  show do |user|
    attributes_table do
      #We want to keep the existing columns
      User.column_names.each do |column|
        row column
      end
      #This is where we add a new column
      row :login_as do
        link_to "#{user.first_name}", login_as_admin_user_path(user), :target => '_blank'
      end
    end
  end

  # Allows admins to login as a user
  member_action :login_as, :method => :get do
    user = User.find(params[:id])
    bypass_sign_in user
    redirect_to user_session_path
  end
end
