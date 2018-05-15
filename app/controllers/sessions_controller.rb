class SessionsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :find_user, only: :create

  def new
  end

  def create
    if @user.validate_password(sessions_params[:password])
      create_session_for(@user)
      redirect_to(root_path, notice: t('controllers.sessions.success.create'))
    else
      redirect_to(new_session_path, alert: t('controllers.sessions.failure.invalid_credentials'))
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to(new_session_path, alert: t('controllers.sessions.success.destroy'))
  end

  private

  def find_user
    @user = User.find_by(email: sessions_params[:email])
    redirect_to(new_session_path, alert: t('controllers.sessions.failure.invalid_credentials')) unless @user
  end

  def sessions_params
    params.require(:user).permit(:email, :password)
  end

  def create_session_for(user)
    session[:current_user_id] = user.id
  end

end
