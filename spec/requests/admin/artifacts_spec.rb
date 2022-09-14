# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/artifacts' do
  let(:artifact) { create(:artifact, :with_photos) }

  before(:all) { login_as_admin }

  describe 'list artifacts' do
    it 'shows artifacts' do
      artifact
      get admin_artifacts_path
      expect(response).to be_ok
    end
  end

  describe 'show artifact' do
    it 'shows the artifact with photos' do
      get admin_artifact_path(artifact.id)
      expect(response).to be_ok
    end
  end

  describe 'edit artifact' do
    it 'renders edit artifact form' do
      get edit_admin_artifact_path(artifact.id)
      expect(response).to be_ok
    end

    it 'redirects back to the artifacts list' do
      patch admin_artifact_path(artifact.id)
      expect(response).to redirect_to(admin_artifacts_path)
    end
  end
end
