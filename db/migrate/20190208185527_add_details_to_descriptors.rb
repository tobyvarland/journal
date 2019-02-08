class AddDetailsToDescriptors < ActiveRecord::Migration[5.2]
  def change
    add_column :descriptors, :text_color, :string, default: nil
    add_column :descriptors, :sort_order, :integer, default: nil
  end
end
