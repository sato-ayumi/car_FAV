class Public::NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.notifications.reverse_order
  end
  
  def mark_as_read
    notification = Notification.find(params[:id])
    notification.update(read: true)
    redirect_to notifications_path
  end
  
end
