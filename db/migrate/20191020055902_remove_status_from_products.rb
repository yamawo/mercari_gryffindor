class RemoveStatusFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :status, :integer
  end
end
