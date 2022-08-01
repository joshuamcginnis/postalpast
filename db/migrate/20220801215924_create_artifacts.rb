class CreateArtifacts < ActiveRecord::Migration[7.0]
  def change
    create_table :artifacts do |t|
      t.column :kind, :integer, default: 0
      t.string :addressed_to_name
      t.string :addressed_from_name
      t.text :addressed_to_message
      t.boolean :color

      t.timestamps
    end
  end
end
