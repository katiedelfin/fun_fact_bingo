class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def authenticate_user!
    if current_user
      true
    else
      session["return_to"] ||= request.url
      redirect_to login_path unless login_redirect? or oauth_callback?
    end
  end
  helper_method :authenticate_user!

  def login_redirect?
    request.path == login_path
  end

  def oauth_callback?
    request.path == oauth_callback_path("google_oauth2")
  end
end
