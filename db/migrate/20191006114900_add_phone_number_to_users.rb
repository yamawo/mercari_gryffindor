class AddPhoneNumberToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :phone_number, :string, unique: true
  end
end
