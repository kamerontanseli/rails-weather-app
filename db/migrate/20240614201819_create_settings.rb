class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.references :user, index: true, foreign_key: true
      t.string :theme, null: false, default: "day"
      t.timestamps
    end
  end
end
