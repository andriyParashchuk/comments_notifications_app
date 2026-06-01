class NotificationsController < ApplicationController
  def mark_as_read
    notification = current_user.notifications.find(params[:id])

    notification.update!(read_at: Time.current)

    redirect_back(fallback_location: root_path)
  end
end
