class CreateDescriptors < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptors do |t|
      t.string :type, null: false
      t.string :label, null: false
      t.string :color, null: false
      t.timestamps
    end
  end
end
