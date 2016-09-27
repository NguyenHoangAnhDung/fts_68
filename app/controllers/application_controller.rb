class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include GeneralMethodsHelper
  include FormatTime

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_in, keys: [:name, :email]
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :email,
      :password, :password_confirmation, :chatwork_id]
    devise_parameter_sanitizer.permit :account_update,
      keys: [:name,:email, :password, :password_confirmation,
      :current_password, :chatwork_id]
  end
end
