ActiveAdmin.register Course do
  menu parent: 'Courses Menu'
  index do
    column :id
    column :name
    column :professor_full_name
    column :student_count
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :professor_full_name
      row :student_count
    end
    active_admin_comments
  end

end