require 'rails_helper'

describe ProductsController do
  describe 'GET #show' do
    # it "assigns the requested puroduct to @product" do
    #   get :show, params: { id: product }
    #   expect(assigns(:product)).to eq product
    # end

    it "showアクションで正しくビューが設定されているか" do
      get :show, params: {  id: 1 }
      expect(response).to render_template :show
    end
  end
end