ActiveAdmin.register ClassRegistration do
  menu parent: 'Courses Menu'
  index do
    column :id
    column :user
    column :course
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :course
    end
    active_admin_comments
  end

end