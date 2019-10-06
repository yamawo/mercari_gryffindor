class ProductsController < ApplicationController
  def index
    @products = Product.new
  end
end
