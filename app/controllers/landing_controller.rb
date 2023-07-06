class LandingController < ApplicationController
  def index
    return redirect_to '/categories' if user_signed_in?
  end
end
