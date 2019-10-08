class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :postal_code,             null: false
      t.string :address_prefecture,      null: false
      t.string :address_city,            null: false
      t.string :address_number,          null: false
      t.string :address_building
      t.string :address_phone
    end
  end
end
