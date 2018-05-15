class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :find_user, only: [:edit, :update, :show]
  before_action :ensure_current_user, only: [:edit, :update]
  before_action :ensure_no_session, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: t('controllers.users.success.create')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: t('controllers.users.success.update')
    else
      render :edit
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_path, alert: t('controllers.users.failure.not_found')) unless @user
  end

  def ensure_current_user
    redirect_to(users_path, alert: t('controllers.users.failure.not_current_user')) unless @user.id == current_user.id
  end

  def ensure_no_session
    redirect_to(users_path, alert: t('controllers.users.failure.user_session_present')) if current_user
  end

end
