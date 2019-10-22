require 'rails_helper'

describe ProductsController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
    
  end
  describe "POST #create" do
    # let(:params) { {product: attributes_for(:product)} }
    context "with valid params" do
      it "creates a new Product" do
        params = { product_images_attributes: [ FactoryBot.attributes_for( :product_image ) ] }
        expect {
          post :create,
          parent: FactoryBot.attributes_for( :product ).merge( params )
        }.to change( Parent, :count ).by( 1 ).add change( Product_image, :count ).by( 1 )
      
      end
    end
  end

end
#  # let(:params) { {product: attributes_for(:product)} }
#  context "log in" do
#   before do
#     login user
#   end

#   context "can save" do #保存できた時
#     subject {
#       post :create,
#       params: params
#     }

#     it "count up product" do #モデルのレコードの総数が1個増えたかどうかを確かめる
#       binding.pry
#       expect{ subject }.to change(Product, :count).by(1)
#     end

#     it "redirects to root_path" do
#       subject
#       expect(response).to redirect_to(root_path)
#     end
#   end
# end