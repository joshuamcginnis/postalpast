class AddSubjectToArtifact < ActiveRecord::Migration[7.0]
  def change
    add_column :artifacts, :subject, :string
  end
end
