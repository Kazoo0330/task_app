class TasksController < ApplicationController
  before_action :login_requirement
  before_action :authenticate_user!, only: %i(new edit update destroy)
  before_action :set_task, only: %i(show edit update destroy)
  before_action :set_labels, only: %i(index new edit create)
  before_action :correct_user?, only: %i(show edit destroy)

  def index
    @tasks = current_user.tasks.order(created_at: :desc)

    if params[:sort_expired]
      @tasks = current_user.tasks.order(expires_on: :asc)
    else
      @tasks = current_user.tasks.order(created_at: :desc)
    end

    if params[:task].present?
      @tasks = @tasks.search_with_title(params[:task][:title])
      @tasks = @tasks.search_with_content(params[:task][:content])
      if params[:task][:status].present?
        @tasks = @tasks.search_with_status(params[:task][:status])
      end
      if params[:task][:label_id].present?
        @tasks = @tasks.search_with_label(params[:task][:label_id])
      end
    end
    @tasks = @tasks.page(params[:page]).per(5)
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
    # binding.pry
    @task = current_user.tasks.build(task_params)
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

    def set_labels
      @labels = Label.all
    end

    def task_params
      params.require(:task).permit(
        :title,
        :content,
        :expires_on,
        :status,
        :priority,
        label_ids: []
      )
    end

    def correct_user?
      @task = Task.find_by(id:params[:id])
      if @task.user_id != current_user.id
        flash[:notice] = t("view.task.no_rights")
        redirect_to tasks_path
      end
    end

end
