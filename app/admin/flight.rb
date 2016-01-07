ActiveAdmin.register Flight do
  menu priority: 4
  index do
    column :date
    column :departure
    column :destination
    column :picture
    column :public
    column :latitude
    column :longitude
    column :created_at
    default_actions
  end

  filter :username
  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :date
      f.input :departure
      f.input :destination
      f.input :picture
      f.input :public
      f.input :latitude
      f.input :longitude
      f.input :created_at
    end
    f.buttons
  end

  show do
    attributes_table do
    row :date
    row :departure
    row :destination
    row :picture
    row :public
    row :latitude
    row :longitude
    row :created_at
    end
    active_admin_comments
  end
end