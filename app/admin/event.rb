ActiveAdmin.register Event do
  index do
    column :id
    column :creator
    column :name
    column :description
    column :start_time
    column :end_time
    column :venue
    column :location
    column :notify_user
    column :notify_hours_until_event
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :creator
      row :name
      row :description
      row :start_time
      row :end_time
      row :venue
      row :location
      row :notify_user
      row :notify_hours_until_event
    end
    active_admin_comments
  end

end