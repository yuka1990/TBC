class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  
   def update
     notification = current_user.notifications.find(params[:id])
     notification.update(read: true)
     case notification.notifiable_type
     when "Permit"
       redirect_to group_permits_path(notification.notifiable.group_id)
     when "Comment"
       redirect_to post_comments_path(notification.notifiable.post_id)
     else
       redirect_to post_path(notification.notifiable.post_id)
     end
   end
   
end
