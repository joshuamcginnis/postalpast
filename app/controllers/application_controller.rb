# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def authenticate_admin_user!
    return true if session[:user] && session[:user]['admin'] == true

    add_return_path_to_session
    redirect_to admin_login_path
  end

  def current_admin_user
    session[:user]
  end

  private

  def add_return_path_to_session
    session[:return_path] = request.path
  end
end
