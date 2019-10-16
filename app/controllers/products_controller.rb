class ProductsController < ApplicationController
  before_action :find_product, only: [:show]

  def show
    @product_images = ProductImage.find(1)
  end

    private

  def find_product
    @product = Product.find(params[:id])
  end

end

  