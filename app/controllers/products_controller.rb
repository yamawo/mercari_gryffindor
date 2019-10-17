class ProductsController < ApplicationController
  
  def index
    @product = Product.new
  end

  def new
    require "base64"
    @product = Product.new

    parents = Category.where(ancestry: nil)
    @parents = [["---", "---"]]
    parents.each do |parent|
      @parents << [parent.name, parent.id]
    end
    @product.product_images.build
    render layout: "selling"
  end

  def create_category
    children = Category.where(ancestry: params[:keyword])#親カテゴリーのvalue
    respond_to do |format|
      format.json
    end
  end
  
  def create_category_children
    @grandchildren = Category.where(ancestry: params[:value])#"親カテゴリー/子カテゴリー"のようにvalueを送る
    respond_to do |format|
      format.json{ render :@grandchildren}
    end
  end
  
  
  
  def creare
    require "base64"
    @product = Product.new(product_params)
    if @product.save
      product_images_params[:images].each do |image|
        @product.product_images.build   # buildをすることで、saveした際にアソシエーションした先にも値を保存する
        product_image = @product.product_images.new(image: image)
        product_image.save
      end
      respond_to do |format|
        format.json
      end
    end
  end

  def edit
    require "base64"
  end

  def privacy_policy
  end
  


  private 
  def product_params
    params.require(:product).permit(:name, :price, :text, :status, :stage, :delivery_responsivility, :delivery_way, :delivery_area, :delivery_day, :category_id, :brand_id)
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end

  def product_images_params
    params.require(:product_images).permit({images: []})
  end
  
end
