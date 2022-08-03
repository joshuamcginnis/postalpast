class AddSubjectDateToArtifacts < ActiveRecord::Migration[7.0]
  def change
    add_column :artifacts, :subject_date, :datetime
  end
end
