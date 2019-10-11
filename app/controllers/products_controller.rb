class ProductsController < ApplicationController
  layout "selling"
  def new
    @product = Product.new
  end

  def index
    @product = Product.new
  end
end
