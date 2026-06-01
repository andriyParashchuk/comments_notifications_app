class HomeController < ApplicationController
  def index
    @notifications = current_user.notifications.unread.includes(:comment).order(created_at: :desc)

    if params[:query].present?
      @comments = Comment.search(params[:query], limit: 20).includes(:user)
    else
      @comments = Comment.includes(:user).order(created_at: :desc)
    end
  end
end
