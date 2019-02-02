class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin?
      @users = User.all
    else
      render 'tasks/index', notice: t("view.template.not_admin")
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id)
    else
      render new_admin_user_path
    end
  end

  def show
    @tasks = @user.tasks
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
    else
      render 'admin/users/edit'
    end
  end

  def destroy
    @user.destroy
    if @user == current_user
      redirect_to tasks_path
    else
      redirect_to admin_users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
