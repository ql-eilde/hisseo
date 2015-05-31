class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :ensure_domain

  # def ensure_domain
  # 	if request.env['HTTP_HOST'] == 'immense-cove-4146.herokuapp.com'
  #    redirect_to "https://www.hisseo.co#{request.env['REQUEST_PATH']}", :status => 301
  #  end
  # end

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:first_name, :last_name, :email, :tel_number, :password, :password_confirmation, :current_password, :profile_img, :iban_number, :bic_number)}
  	devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :profile_img)}
  end
end
