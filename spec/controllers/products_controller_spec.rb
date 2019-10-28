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
    fail_path = File.join(Rails.root, 'public/images/a15451168d02bf14fd28c9110b161f8d.jpg')
    fail = Rack::Test::UploadedFile.new(fail_path)
    binding.pry
    image = { "product_images_attributes" => {"0" => {"image" => fail}} } 
    let(:params) { { product: attributes_for(:product_with_images, :image) } }
    
    context "log in" do
      before do
        login user
      end

      context "can save" do #保存できた時
        category = FactoryBot.create(:category)
        user = FactoryBot.create(:user)
        size = FactoryBot.create(:size)
        brand = FactoryBot.create(:brand)
        subject {
          post :create,
          params: params.merge(image)
        }
        
        it "count up product" do #モデルのレコードの総数が1個増えたかどうかを確かめる
          product = FactoryBot.build(:product_with_images)
          expect{ subject }.to change(Product, :count).by(1)
        end
       
        it "count up product_image" do #モデルのレコードの総数が1個増えたかどうかを確かめる
          product = create(:product_with_images)
          hash = {product: params[:product].merge(image)}
          expect{post :create, params: hash}.to change(ProductImage, :count).by(1)
        end

        it "redirects to root_path" do
          subject
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
