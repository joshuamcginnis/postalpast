class AddSubjectDescriptionToArtifact < ActiveRecord::Migration[7.0]
  def change
    add_column :artifacts, :subject_description, :text
  end
end
