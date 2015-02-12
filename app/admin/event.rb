ActiveAdmin.register Event do
  index do
    column :id
    column :creator
    column :name
    column :description
    # column :start_time
    # column :end_time
    column :location_name
    column :location_address
    column :invited_users_count do |event|
      event.invited_users.count
    end
    column :attending_users_count do |event|
      event.attending_users.count
    end
    # column :notify_user
    # column :notify_hours_until_event
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :creator
      row :name
      row :description
      # row :start_time
      # row :end_time
      row :venue
      row :location
      # row :notify_user
      # row :notify_hours_until_event
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Event Details" do
      f.input :creator
      f.input :name
      f.input :description
      # f.input :start_time, :as => :just_datetime_picker
      # f.input :end_time, :as => :just_datetime_picker
      f.input :venue
      f.input :location
      # f.input :notify_user
      # f.input :notify_hours_until_event
    end
    f.actions
  end


end