class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.references :artifact, null: false, foreign_key: true
      t.text :image_data

      t.timestamps
    end
  end
end
