class CreateBoxes < ActiveRecord::Migration[7.1]
  def change
    create_table :boxes do |t|
      t.float :length
      t.float :width
      t.float :height
      t.float :max_weight
      t.timestamps
    end
  end
end
