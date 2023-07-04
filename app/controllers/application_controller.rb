class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  skip_before_action :authenticate_user!, if: :landing_page!
  skip_before_action :verify_authenticity_token, if: :landing_page!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found!

  def record_not_found!
    render 'shared/_404'
  end

  def landing_page!
    request.fullpath.to_s.include?('landing')
  end
end
