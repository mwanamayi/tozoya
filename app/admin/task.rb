ActiveAdmin.register Task do
  index do
    column :title
    column :user
    default_actions
  end

  filter :title

  form do |f|
    f.inputs "Task Details" do
      f.input :title
      f.input :user
    end
    f.buttons
  end

  show do
    attributes_table do
      row :title
    end
    active_admin_comments
  end
end