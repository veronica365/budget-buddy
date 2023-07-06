class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  skip_before_action :authenticate_user!, if: :landing_page!
  skip_before_action :verify_authenticity_token, if: :landing_page!
  before_action :update_allowed_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found!

  def record_not_found!
    render 'shared/_404'
  end

  def not_found_method
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

  def landing_page!
    request.fullpath.to_s.include?('landing')
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
  end
end
