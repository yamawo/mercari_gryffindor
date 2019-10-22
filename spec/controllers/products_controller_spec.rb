require 'rails_helper'

describe ProductsController do
  describe 'GET #show' do
    it "assigns the requested puroduct to @product" do
      create(:brand)
      create(:size)
      create(:category)
      create(:user)
      product = create(:product)
      get :show, params: { id: product }
      expect(assigns(:product)).to eq product
    end

    it "renders the :show template" do
      create(:brand)
      create(:size)
      create(:category)
      create(:user)
      product = create(:product)
      get :show, params: { id: product }
      expect(response).to render_template :show 
    end

    it "showアクションで正しくビューが設定されているか" do
      create(:brand)
      create(:size)
      create(:category)
      create(:user)
      product = create(:product)
      get :show, params: {  id: product }
      expect(response).to render_template :show
    end
  end
  let(:brand) { create(:brand) }
  let(:size) { create(:size) }
  let(:category) { create(:category) }
  let(:user) { create(:user) }
     describe '#destroy' do
      context 'log in' do
        before do
          login user
        end
        it "destroyアクションで正しくビューが設定されているか" do
          create(:brand)
          create(:size)
          create(:category)
          create(:product)
          get :destroy, params: {  id: 2 }
          expect(response).to render_template :destroy
      end
    end
  end
end