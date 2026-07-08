module NotificationsHelper
  def format_notification_date(date)
    today = Date.today
    
    case date
    when today
      "Today"
    when today - 1
      "Yesterday"
    else
      date.strftime("%b %d, %Y")
    end
  end
end
