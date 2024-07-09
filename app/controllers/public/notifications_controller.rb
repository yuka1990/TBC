class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  
   def update
     notification = current_user.notifications.find(params[:id])
     notification.update(read: true)
     case notification.notifiable_type
     when "Permit"
       redirect_to group_permits_path(notification.notifiable.group_id)
     else
       redirect_to my_page_path(notification.notifiable.user)
     end
   end
   
end
