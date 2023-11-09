class CreateActions < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :coordinate, null: false, foreign_key: true
      t.string :stamp

      t.timestamps
    end
  end
end
