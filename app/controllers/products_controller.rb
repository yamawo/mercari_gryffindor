class ProductsController < ApplicationController
  def mypage
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
  
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
end
