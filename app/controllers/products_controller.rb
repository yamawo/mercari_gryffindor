class ProductsController < ApplicationController
  before_action :find_product, only: [:show]

  def new
  end

  def show
    @user = @product.user
    @products = @user.products
  end
  
  private
  
  def find_product
    @product = Product.find(params[:id])
  end

end

  