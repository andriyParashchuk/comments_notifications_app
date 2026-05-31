class HomeController < ApplicationController
  def index
    @comments = Comment.includes(:user).order(created_at: :desc)
  end
end