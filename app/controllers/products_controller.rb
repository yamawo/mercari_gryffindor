class ProductsController < ApplicationController
  
  def index
    @product = Product.new
  end

  def new
    @product = Product.new
    @product.product_images.build
    render layout: "selling"
  end

  def creare
    product = Product.new(product_params)
    product.save
  end

  def privacy_policy
      
  end

  private 
  def product_params
    params.require(:product).permit(:name, :price, :text, :status, :stage, :delivery_responsivility, :delivery_way, :delivery_area, :delivery_day)
  end
  
end
