ActiveAdmin.register User do
  menu priority: 3
  index do
    column :username
    column :email
    column :school
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :username
  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :school
    end
    f.buttons
  end

  show do
    attributes_table do
      row :username
      row :email
      row :school
      row :authentication_token
      row :confirmed_at
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
    end
    active_admin_comments
  end
end