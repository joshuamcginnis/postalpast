class CreateStamps < ActiveRecord::Migration[7.0]
  def change
    create_table :stamps do |t|
      t.string :name
      t.decimal :price
      t.references :artifact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
