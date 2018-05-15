class TasksController < ApplicationController

  before_action :find_task, only: [:edit, :update, :show, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('controllers.tasks.success.create')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.save
      redirect_to task_path(@task), notice: t('controllers.tasks.success.update')
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: t('controllers.tasks.success.destroy')
    else
      redirect_to tasks_path, alert: t('controllers.tasks.failure.destroy')
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :start, :end, :user_id)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
    redirect_to(tasks_path, alert: t('controllers.tasks.failure.not_found')) unless @task
  end

end
