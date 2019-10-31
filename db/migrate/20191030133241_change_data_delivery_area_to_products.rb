class ChangeDataDeliveryAreaToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :delivery_area, :integer
  end
end
