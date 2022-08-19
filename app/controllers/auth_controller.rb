class AuthController < ApplicationController
  layout 'auth'

  def index
  end

  def login
    if valid_credentials?
      session[:user] = { admin: true }
      redirect_to admin_root_path
    else
      flash.now.alert = 'Invalid password.'
      render :index
    end
  end

  def logout
    session[:user] = nil
    redirect_to admin_login_path
  end

  private

  def valid_credentials?
    credentials = Rails.application.secrets[:admin_credentials]
    login_params[:username] == credentials[:username] && \
      login_params[:password] == credentials[:password]
  end

  def login_params
    params.permit(:authenticity_token, :username, :password)
  end
end
