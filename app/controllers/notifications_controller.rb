class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    current_user.notifications.where(read: false).update_all(read: true)
  end
end
