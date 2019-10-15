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
    @product = Product.new(product_params)
    @product.product_images.build(product_params[:product_images_attributes])
    if @product.save
    end
  end

  def privacy_policy
      
  end

  private 
  def product_params
    params.require(:product).permit(:name, :price, :text, :status, :stage, :delivery_responsivility, :delivery_way, :delivery_area, :delivery_day, :category_id, :brand_id, product_images_attributes: [:id, :image, :product_id])
  end
  
end
