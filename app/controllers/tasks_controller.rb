class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @q = Task.includes(:user).order(:end_time).ransack(params[:q])
    @tasks = @q.result(distinct: true)
    # 加分頁會有問題, 會將所有的使用者任務做加總, 而不是針對某一個使用者去篩選任務數量
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_param)
    if @task.save
      redirect_to tasks_path, notice: "任務新增成功"
    else
      render :new, notice: "任務新增失敗"
    end
  end

  def show
    @task = Task.find(params[:id])
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
    params.require(:task).permit(:name, :content, :end_time, :state, :priority)
  end

  def find_task
    @task = current_user.tasks.find(params[:id])
  end

end
