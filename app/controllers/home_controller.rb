class HomeController < ApplicationController
  def index
    @comments = Comment.includes(:user).order(created_at: :desc)
    @notifications = current_user.notifications.unread.includes(:comment).order(created_at: :desc)
  end
end
