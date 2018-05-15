class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  attr_accessor :current_user

  # Private instance methods
  private

  def authenticate_user!
    @current_user ||= User.find_by(id: session[:current_user_id])
    redirect_to(new_session_path, alert: t('controllers.application.failure.not_authenticated')) unless @current_user
  end

end
