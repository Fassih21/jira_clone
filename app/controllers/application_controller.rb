class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  # Rescue from unauthorized access errors raised by Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :role ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :role ])
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not allowed to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
