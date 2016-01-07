ActiveAdmin.register User do
  menu priority: 3
  index do
    column :full_name
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :created_at
    default_actions
  end

  filter :username
  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :entity_name
    end
    f.buttons
  end

  show do
    attributes_table do
    row :full_name
    row :email
    row :current_sign_in_at
    row :last_sign_in_at
    row :sign_in_count
    row :created_at
    end
    active_admin_comments
  end
end