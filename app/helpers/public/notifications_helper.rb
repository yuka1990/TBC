module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Permit"
      "#{notification.notifiable.user.nickname} applied to join '#{notification.notifiable.group.name}'"
    when "Comment"
      "#{notification.notifiable.user.nickname} commented on your recipe '#{notification.notifiable.post.title}'"
    else
      "#{notification.notifiable.user.nickname} liked your recipe '#{notification.notifiable.post.title}'"
    end
  end
end
