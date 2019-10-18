require 'rails_helper'
describe User do
    describe '#create' do
        
        # 各項目の値が全て埋まっていたら登録されるかをテスト
        it "is valid with all" do
            user = build(:user)
            expect(user).to be_valid
        end

        # 重複したemailが存在する場合にエラーが出るかテスト
        it "is invalid with duplicate email address" do
            user = create(:user)
            another_user = build(:user)
            another_user.valid?
            expect(another_user.errors[:email]).to include("has already been taken")
        end

        # 重複したphone_numberが存在する場合にエラーが出るかテスト
        it "is invalid with duplicate phone_number" do
            user = create(:user)
            another_user = build(:user)
            another_user.valid?
            expect(another_user.errors[:phone_number]).to include() 
        end

        # passwordが同じでない場合にエラーが出るかテスト
        it "is  error" do
            user = build(:user, password_confirmation: "11111111")
            user.valid?
            expect(user.errors[:password_confirmation]).to include("doesn't match Password")
        end

        #passwordが同じである場合に登録されるかどうかテスト
        it "is not error" do
            user = build(:user)
            user.valid?
            expect(user.errors[:password_confirmation]).not_to be_present
        end

        # 各項目の値がnilのときにエラーが出るかをテスト
        it "is invalid without a last_name" do
            user = build(:user, last_name: "")
            user.valid?
            expect(user.errors[:last_name]).to include("can't be blank")
        end

        it "is invalid without a first_name" do
            user = build(:user, first_name: "")
            user.valid?
            expect(user.errors[:first_name]).to include("can't be blank")
        end

        it "is invalid without a last_name_kana" do
            user = build(:user, last_name_kana: "")
            user.valid?
            expect(user.errors[:last_name_kana]).to include("can't be blank")
        end

        it "is invalid without a first_name_kana" do
            user = build(:user, first_name_kana: "")
            user.valid?
            expect(user.errors[:first_name_kana]).to include("can't be blank")
        end

        it "is invalid without a birthdate_year" do
            user = build(:user, birthdate_year: "")
            user.valid?
            expect(user.errors[:birthdate_year]).to include("can't be blank")
        end

        it "is invalid without a birthdate_month" do
            user = build(:user, birthdate_month: "")
            user.valid?
            expect(user.errors[:birthdate_month]).to include("can't be blank")
        end

        it "is invalid without a birthdate_day" do
            user = build(:user, birthdate_day: "")
            user.valid?
            expect(user.errors[:birthdate_day]).to include("can't be blank")
        end

        it "is invalid without a email" do
            user = build(:user, email: "")
            user.valid?
            expect(user.errors[:email]).to include("can't be blank")
        end

        it "is invalid without a phone_number" do
            user = build(:user, phone_number: "")
            user.valid?
            expect(user.errors[:phone_number]).to include("can't be blank")
        end

        it "is invalid without a password" do
            user = build(:user, password: "")
            user.valid?
            expect(user.errors[:password]).to include("can't be blank")
        end

        it "is invalid without a nickname" do
            user = build(:user, nickname: "")
            user.valid?
            expect(user.errors[:nickname]).to include("can't be blank")
        end

        it "はカタカナで入力して下さい。" do
            user = build(:user, last_name_kana: "めるかり")
            user.valid?
            expect(user.errors[:last_name_kana]).to include('はカタカナで入力して下さい。')
        end

        it "はカタカナで入力して下さい。" do
            user = build(:user, first_name_kana: "めるかり")
            user.valid?
            expect(user.errors[:first_name_kana]).to include('はカタカナで入力して下さい。')
        end
    end
end
