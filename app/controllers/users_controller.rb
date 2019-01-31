class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    redirect_to tasks_path, notice: t("view.task.diff_user") unless @user == current_user
  end

  # def edit
  # end

  private
end
