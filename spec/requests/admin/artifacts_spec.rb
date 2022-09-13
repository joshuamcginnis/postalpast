# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/artifacts' do
  let!(:artifact) { create(:artifact, :with_photos) }

  before { login_as_admin }

  it 'shows artifacts' do
    get admin_artifacts_path
    expect(response).to be_ok
  end

  it 'shows the artifact with photos' do
    get admin_artifact_path(artifact.id)
    expect(response).to be_ok
  end

  it 'renders edit artifact form' do
    get edit_admin_artifact_path(artifact.id)
    expect(response).to be_ok
  end
end
