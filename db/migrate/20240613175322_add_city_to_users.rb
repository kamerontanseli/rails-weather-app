class AddCityToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_index :locations, :city if index_exists?(:locations, :city)
    add_reference :locations, :user, index: true
  end
end
