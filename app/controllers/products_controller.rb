class ProductsController < ApplicationController
  def mypage
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
  
end
