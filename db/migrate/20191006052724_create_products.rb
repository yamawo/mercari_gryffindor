class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false 
      t.integer :price, null: false
      t.text :text, null: false
      t.integer :status, null: false
      t.string :stage, null: false
      t.string :delivery_responsivility, null: false
      t.string :delivery_way, null: false
      t.string :delivery_area, null: false
      t.string :delivery_day, null: false
      t.timestamps
    end
  end
end

# 該当テーブルが無い為、外部キーが作れませんでした
# t.references :user, foreign_key: true, null: false
# t.references :buyer, foreign_key: true
# t.references :category, foreign_key: true, null: false
# t.references :brand, foreign_key: true
# t.references :size, foreign_key: true