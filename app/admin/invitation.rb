ActiveAdmin.register Invitation do
  menu parent: 'Events Menu'
  index do 
    column :id
    column :event_name
    column :creator
    column :invited_user_name
    column("Status") do |invitation| 
      invitation.accepted? ? "IN" : "OUT"
    end
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :event_name
      row :invited_user_name
    end
    active_admin_comments
  end

end