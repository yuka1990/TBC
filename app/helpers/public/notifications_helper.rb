module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Group"
      "#{notification.notifiable.user.nickname}さんが#{notification.notifiable.group.name}に参加申請しました"
    else
      "投稿した#{notification.notifiable.post.title}が#{notification.notifiable.user.nickname}さんにいいねされました"
    end
  end
end
