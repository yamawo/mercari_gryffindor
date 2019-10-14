class ProductsController < ApplicationController
  def show
    @products = Product.find(1)
    @users = User.find(1)
    @images = Image.find(2)
  end
end
