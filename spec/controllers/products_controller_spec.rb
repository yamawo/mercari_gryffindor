require 'rails_helper'

describe ProductsController do

  describe 'GET #show' do
    
    it "renders the :show template" do
      get :show, params: {  id: 2 }  
      expect(response).to render_template :new
    end
  end
end