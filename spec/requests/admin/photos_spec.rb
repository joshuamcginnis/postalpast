# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/photos' do
  let(:photo) { create(:photo) }

  before(:all) { login_as_admin }

  it 'shows pictures' do
    photo
    get admin_photos_path
    expect(response).to be_ok
  end

  describe 'show photo' do
    it 'shows the photo' do
      get admin_photo_path(photo.id)
      expect(response).to be_ok
    end
  end

  describe 'edit photo' do
    it 'renders edit photo form' do
      get edit_admin_photo_path(photo.id)
      expect(response).to be_ok
    end
  end
end
