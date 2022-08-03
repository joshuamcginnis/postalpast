class ChangeDefaultOfColor < ActiveRecord::Migration[7.0]
  def change
    change_column_default :artifacts, :color, true
  end
end
