class ProductsController < ApplicationController
  before_action :find_product, only: [:show]

  def index
    ladies = Category.find_by(name: "レディース")
    @ladies = Product.where(category_id: ladies.indirects.ids).limit(10)
    chanel = Brand.find_by(name: "シャネル")
    @chanel = Product.where(brand_id: chanel.id).limit(10)
  end

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
