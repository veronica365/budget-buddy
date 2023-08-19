class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  skip_before_action :authenticate_user!, if: :landing_page!
  skip_before_action :verify_authenticity_token, if: :landing_page!
  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :_private_validate_params

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found!

  def record_not_found!
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
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

  def _private_validate_params
    url_params = [(params[:category_id] || params[:id]), params[:id]]
    category_id, transaction_id = *url_params

    @category_id = Integer(category_id) unless category_id.nil?
    @transaction_id = Integer(transaction_id) unless transaction_id.nil?
  rescue ArgumentError
    not_found_method
  end
end
