class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i(new edit update destroy)
  before_action :set_task, only: %i(show edit update destroy)

  def index
    @tasks = Task.all.order(created_at: :desc)
    if params[:sort_expired]
      @tasks = Task.all.order(expires_on: :asc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end

    # @search_tasks = Task.search(params[:search])

    # search functionalities are below.
    if params[:task].present?
      @tasks = @tasks.search_with_title(params[:task][:title]) #if params[:task][:title].present?
      @tasks = @tasks.search_with_content(params[:task][:content])
      if params[:task][:status].present?
        @tasks = @tasks.search_with_status(params[:task][:status])
      end
    end
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
      params.require(:task).permit %i(title content expires_on status)
    end
end
