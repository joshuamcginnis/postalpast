class AddFaceToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :face, :integer
  end
end
