class AddPostmarkDateToArtifact < ActiveRecord::Migration[7.0]
  def change
    add_column :artifacts, :postmarked_at, :datetime
  end
end
