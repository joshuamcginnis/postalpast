# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/photos' do
  before { login_as_admin }

  it 'does stuff' do
    get '/admin/photos'
    expect(response).to be_ok
  end
end
