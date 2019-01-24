class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :basic_certifiaction

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def login_requirement
    redirect_to new_user_session_path, notice: t("view.template.login?") unless user_signed_in?
  end

  # def basic_certifiaction
  #   authenticate_or_request_with_http_basic do |name, password|
  #     name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
  #   end
  # end
end
