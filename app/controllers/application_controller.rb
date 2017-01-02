class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :select_list_menu

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter do
    # can can monkey patch
    resource = controller_name.singularize.to_sym
    method = 'allowed_params'
    params[resource] &&= send(method)[resource] if respond_to?(method, true)
    # alias resource_params allowed_params
  end

  def select_list_menu
    @goList = List.all.order(:list_id).distinct
  end


private
  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_to '/'
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :picture])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username])
  end
end
