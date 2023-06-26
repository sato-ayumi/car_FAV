class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.unread_notifications.reverse_order
  end

  def mark_as_read
    notification = Notification.find(params[:id])
    notification.update(read: true)
    redirect_to notifications_path
  end

  def all_mark_as_read
    current_user.notifications.update_all(read: true)
    redirect_to notifications_path
  end

end
