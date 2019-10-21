require 'rails_helper'

describe ProductsController do
  # describe 'GET #show' do
  #   it "assigns the requested puroduct to @product" do
  #     create(:brand)
  #     create(:size)
  #     create(:category)
  #     create(:user)
  #     product = create(:product)
  #     get :show, params: { id: product }
  #     expect(assigns(:product)).to eq product
  #   end

  #   it "renders the :show template" do
  #     create(:brand)
  #     create(:size)
  #     create(:category)
  #     create(:user)
  #     product = create(:product)
  #     get :show, params: { id: product }
  #     expect(response).to render_template :show 
  #   end

  #   it "showアクションで正しくビューが設定されているか" do
  #     get :show, params: {  id: 1 }
  #     expect(response).to render_template :show
  #   end

    describe 'GET #destroy' do
      it "destroyアクションで正しくビューが設定されているか" do
        create(:brand)
        create(:size)
        create(:category)
        create(:user)
        create(:product)
        get :destroy, params: {  id: 2 }
        expect(response).to render_template :destroy
      # end
    end
  end
end