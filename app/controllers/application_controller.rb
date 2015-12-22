class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_found
    flash[:alert] = "Sorry. We could not find what you're looking for."
    redirect_to root_path
  end
end
