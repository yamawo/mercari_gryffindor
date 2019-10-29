class RemoveStageFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :stage, :string
  end
end
