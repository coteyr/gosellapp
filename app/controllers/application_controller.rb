class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :select_list_menu

  before_action :configure_permitted_parameters, if: :devise_controller?

  def select_list_menu
    @goList = List.all.order(:list_id).distinct
  end


  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :picture])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username])
    end
end
