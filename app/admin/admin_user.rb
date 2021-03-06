ActiveAdmin.register AdminUser do
  menu priority: 2
  index do
    column :username
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :username
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end