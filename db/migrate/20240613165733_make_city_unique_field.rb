class MakeCityUniqueField < ActiveRecord::Migration[7.1]
  def change
    add_index :locations, :city, unique: true
  end
end
