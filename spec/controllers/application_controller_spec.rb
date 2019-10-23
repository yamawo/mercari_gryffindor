require 'rails_helper'

describe ApplicationController do
  it "search_forのビューが表示されるか" do
    get :search_for, params: { q: { name_cont: "アイテム" }}
    expect(response).to render_template :search_for
  end

  it "検索したキーワードで検索できるか" do
    get :search_for, params: { q: { name_cont: "アイテム" }}
    @q = Product.search(name_cont: "アイテム")
    @product = @q.result(distinct: true)
    expect(assigns(:products)).to eq(@product)
  end
end
