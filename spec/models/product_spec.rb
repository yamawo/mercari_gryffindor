require 'rails_helper'
RSpec.describe Product, type: :model do
  describe '#create' do
    context "can save" do
      it "is invalid without a name" do
        product = build(:product, name: "")
        product.valid?
        expect(product.errors[:name]).to include("を入力してください")
      end

      it "is invalid without a text" do
        product = build(:product, text: "")
        product.valid?
        expect(product.errors[:text]).to include("を入力してください")
      end
      
      it "is invalid without a price" do
        product = build(:product, price: "")
        product.valid?
        expect(product.errors[:price]).to include("を入力してください")
      end

      it "is invalid without a status" do
        product = build(:product, status: "")
        product.valid?
        expect(product.errors[:status]).to include("を入力してください")
      end

      it "is invalid without a delivery_responsivility" do
        product = build(:product, delivery_responsivility: "")
        product.valid?
        expect(product.errors[:delivery_responsivility]).to include("を入力してください")
      end

      it "is invalid without a delivery_way" do
        product = build(:product, delivery_way: "")
        product.valid?
        expect(product.errors[:delivery_way]).to include("を入力してください")
      end
      
      it "is invalid without a delivery_area" do
        product = build(:product, delivery_area: "")
        product.valid?
        expect(product.errors[:delivery_area]).to include("を入力してください")
      end

      it "is invalid without a delivery_day" do
        product = build(:product, delivery_day: "")
        product.valid?
        expect(product.errors[:delivery_day]).to include("を入力してください")
      end

      it "is invalid without a category_id" do
        product = build(:product, category_id: nil)
        product.valid?
        expect(product.errors[:category_id]).to include("を入力してください")
      end
      
      it "is invalid without a user_id" do
        product = build(:product, user_id: nil)
        product.valid?
        expect(product.errors[:user_id]).to include("を入力してください")
      end

    end
  end
end