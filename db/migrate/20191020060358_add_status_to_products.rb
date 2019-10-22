class AddStatusToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :status, :integer, default: 0, null: false
    add_index :products, :status
  end
end
