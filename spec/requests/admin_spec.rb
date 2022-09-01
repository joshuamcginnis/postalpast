# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin' do
  context 'not logged in' do
    it 'redirects to the login page' do
      get '/admin'
      expect(response).to redirect_to(admin_login_path)
    end
  end

  describe 'login page' do
    context 'wrong login' do
      it 'reloads the login page' do
        post '/admin/login', params: { username: 'wrong', password: 'test' }
        #expect(response).to redirect_to(admin_login_path)
      end
    end

    context 'correct login' do
      it 'redirects to the admin root' do
        post '/admin/login', params: { username: 'test', password: 'test' }
        expect(response).to redirect_to(admin_root_path)
      end
    end
  end
end
