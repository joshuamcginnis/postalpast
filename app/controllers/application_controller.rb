class ApplicationController < ActionController::Base
  def authenticate_admin_user!
    return true if session[:user] && session[:user]['admin'] == true
    redirect_to admin_login_path
  end

  def current_admin_user
    session[:user]
  end
end
