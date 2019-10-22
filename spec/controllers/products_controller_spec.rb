require 'rails_helper'

describe ProductsController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
    
  end
  describe "#create" do 
    # let(:product) {attributes_for(:product)}
    # let(:product_image) {attributes_for(:product_image)}
    # product["product_images_attributes"] = {"0" => product_image}
    params = { product_images_attributes: [FactoryBot.attributes_for(:product_image)]}
    context "log in" do
      before do
        login user
      end

      context "can save" do #保存できた時
        subject {
          post :create,
          product: FactoryBot.build(:product, user_id: "1", category_id: "1", size_id: product.size.id, brand_id: product.brand.id, category: "メンズ", product_images_attributes: "sample")
        }

        it "count up product" do #モデルのレコードの総数が1個増えたかどうかを確かめる
          binding.pry
          expect{ subject }.to change(Product, :count).by(1)
        end

        it "redirects to root_path" do
          subject
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
