ActiveAdmin.register School do
  menu priority: 4
  index do
    column :id
    column :name
    column :student_count
    column :professor_count
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :students_count
      row :professors_count
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Event Details" do
      f.input :name
    end
    f.actions
  end


end