class AddSubjectAddress < ActiveRecord::Migration[7.0]
  def change
    enable_extension :hstore
    add_column :artifacts, :subject_address, :hstore
    add_column :artifacts, :postmark_address, :hstore
    add_column :artifacts, :to_address, :hstore
    add_column :artifacts, :from_address, :hstore
  end
end
