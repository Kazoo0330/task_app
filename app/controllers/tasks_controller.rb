class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i(new edit update destroy)
  before_action :set_task, only: %i(show edit update destroy)

  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def show; end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "taskを作成しました✨ "
    else
      render "new"
    end
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task.id), notice: "taskを更新しました✅ "
    else
      render "edit"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "taskを削除しました🗑 "
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit %i(title content)
    end
end
