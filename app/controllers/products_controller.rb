class ProductsController < ApplicationController
  
  def index
    @product = Product.new
  end

  def new
    @product = Product.new
    parents = Category.where(ancestry: nil)
    @parents = [["---", "---"]]
    parents.each do |parent|
      @parents << [parent.name, parent.id]
    end
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
    product = Product.new(product_params)
    product.save
  end

  def privacy_policy
      
  end
  


  private 
  def product_params
    params.require(:product).permit(:image, :name, :text, :category_id, :status, :delivery_responsivility, :delivery_way, :delivery_area, :delivery_day, :price)
  end
  
end
