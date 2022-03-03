class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(:end_time)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_param)
    if @task.save
      redirect_to tasks_path, notice: "任務新增成功"
    else
      render :new, notice: "任務新增失敗"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_param)
      redirect_to tasks_path, notice: "任務已修改成功"
    else
      render :edit, notice: "任務修改失敗"
    end
  end

  def destroy
    if @task
      @task.destroy
    end
    redirect_to tasks_path, notice: "已刪除任務"
  end

  private
  def task_param
    params.require(:task).permit(:name, :content, :end_time)
  end

  def find_task
    @task = Task.find(params[:id])
  end

end
