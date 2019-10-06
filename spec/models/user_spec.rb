require 'rails_helper'
describe User do
    describe '#create' do
        it "validationのテストします。Usersの全てのカラムが対象です。" do
            user = User.new(last_name: "")
            user.valid?
            expect(user.errors[:last_name]).to include("can't be blank")
        end
    end
end
