class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    check_params_not_blank

    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      set_user_id_in_session(user)

      redirect_to root_path
    else
      flash.now[:alert] = "Invalid credentials"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    remove_user_id_from_session
    redirect_to login_path
  end

  private

  def check_params_not_blank
    if session_params.values.join.blank?
      flash[:alert] = "Email and password can't be blank"
    end
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
