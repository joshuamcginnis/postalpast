# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/login' do
  context 'when not logged in' do
    it 'redirects to the login page' do
      get admin_root_path
      expect(response).to redirect_to(admin_login_path)
    end
  end

  context 'when accessing a resource not logged in' do
    it 'redirects to the previous' do
      get admin_photos_url
      expect(response).to redirect_to(admin_login_path)

      post admin_login_path, params: { username: 'test', password: 'test' }
      expect(response).to redirect_to(admin_photos_path)
    end
  end

  describe 'login page' do
    context 'with incorrect login credentials' do
      it 'reloads the login page' do
        post admin_login_path, params: { username: 'wrong', password: 'test' }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with correct login credentials' do
      it 'redirects to the admin root' do
        post admin_login_path, params: { username: 'test', password: 'test' }
        expect(response).to redirect_to(admin_root_path)
      end
    end
  end

  describe 'logout' do
    it 'redirects to the login page' do
      login_as_admin
      get admin_logout_path
      expect(response).to redirect_to(admin_login_path)
    end
  end
end
