module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Permit"
      "#{notification.notifiable.user.nickname} has applied to join '#{notification.notifiable.group.name}'"
    else
      "#{notification.notifiable.user.nickname} liked your recipe '#{notification.notifiable.post.title}'"
    end
  end
end
