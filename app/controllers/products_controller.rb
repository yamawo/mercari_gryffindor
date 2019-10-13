class ProductsController < ApplicationController
  
 

  def index
    @product = Product.new
  end

  def new
    @product = Product.new
    render layout: "selling"
  end

  def creare
    product = Product.new(product_params)
    product.save
  end

  private 
  def product_params
    params.require(:user).permit(:image, :name, :text, :category_id, :status, :delivery_responsivility, :delivery_way, :delivery_area, :delivery_day, :price)
  end
end
