class CreateCoordinates < ActiveRecord::Migration[6.1]
  def change
    create_table :coordinates do |t|
      t.integer :user_id
      t.integer :style
      t.string :introduction
      t.boolean :is_published, default: true
      t.timestamps
    end
  end
end
