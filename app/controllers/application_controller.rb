class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  before_action :authenticate_user!

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    redirect_to login_path unless user_signed_in?
  end

  def set_user_id_in_session(user)
    session[:user_id] = user.id
  end

  def remove_user_id_from_session
    session.delete(:user_id)
  end
end