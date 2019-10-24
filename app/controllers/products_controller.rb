class ProductsController < ApplicationController
  
  def index
    @product = Product.new
  end
  
  def new
    @product = Product.new
    
    parents = Category.where(ancestry: nil)
    @parents = [["---", "---"]]
    @parent = "---"
    parents.each do |parent|
      @parents << [parent.name, parent.id]
    end
    
    @product.product_images.build
    render layout: "selling"
  end
  
  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to controller: :products, action: :index
  end
  
  def edit
    @edit_product = Product.find(params[:id])
    
    #孫カテゴリーを取得
    grandchild = @edit_product.category_id
    @grandchild = Category.find(grandchild)
    grandchildren = Category.where(ancestry: @grandchild.ancestry)
    @grandchildren = [["---", "---"]]
    grandchildren.each do |grandchild|
      @grandchildren << [grandchild.name, grandchild.id]
    end
    #子カテゴリーを取得
    @child = @grandchild.parent
    children = Category.where(ancestry: @child.ancestry)
    @children = [["---", "---"]]
    children.each do |child|
      @children << [child.name, child.id]
    end
    #親カテゴリーを取得
    @parent = @child.parent
    parents = Category.where(ancestry: @parent.ancestry)
    @parents = [["---", "---"]]
    parents.each do |parent|
      @parents << [parent.name, parent.id]
    end
    
    respond_to do |format|
      format.json
      format.html
    end
    
    #サイズを取得
    g_id = @grandchild.id
    p_id = @child.id
    if p_id == 2 || p_id == 21 || p_id == 43 || p_id == 62 || p_id == 78 || p_id == 186 || p_id == 201 || p_id == 214 || p_id == 238 || p_id == 270 || g_id == 1045 || g_id == 1057
      sizes = Size.where(id: 1..10)#服のサイズ
    elsif p_id == 248 || g_id == 1042 || g_id == 1053
      sizes = Size.where(id: 11..26)#メンズ靴サイズ
    elsif p_id == 67 || g_id == 1043 || g_id == 1054
      sizes = Size.where(id: 27..42)#レディース靴サイズ
    elsif p_id == 346 || p_id == 358 || p_id == 367
      sizes = Size.where(id: 62..67)#ベビー服~95cmサイズ
    elsif p_id == 376 || p_id == 395 || p_id == 410 || g_id == 1047 || g_id == 1055
      sizes = Size.where(id: 48..54)#キッズ服~100cmサイズ
    elsif p_id == 419 || g_id == 1055 || g_id == 1044
      sizes = Size.where(id: 55..62)#キッズ・ベビー靴サイズ
    elsif g_id == 927
      sizes = Size.where(id: 68..77)#テレビサイズ
    elsif g_id == 1234
      sizes = Size.where(id: 90..95)#オートバイサイズ
    elsif g_id == 1254
      sizes = Size.where(id: 96..103)#ヘルメットサイズ
    elsif p_id == 1201
      sizes = Size.where(id: 104..116)#タイヤサイズ
    elsif g_id == 1052
      sizes = Size.where(id: 117..123)#スキー板のサイズ
    elsif g_id == 1040
      sizes = Size.where(id: 124..130)#スノーボードのサイズ
    end
    @sizes = ["---"]
    sizes.each do |size|
      @sizes << [size.name, size.id]
    end
    render layout: false
  end

  def update
  end

  def create_category_children
    @children = Category.where(ancestry: params[:value])#親カテゴリーのvalue
    respond_to do |format|
      format.json
    end
  end

  def create_category_grandchildren
    @grandchildren = Category.where(ancestry: params[:value])#"親カテゴリー/子カテゴリー"のようにvalueを送る
    respond_to do |format|
      format.json
    end
  end

  def search_size
    id = params[:value]
    category = Category.find(id)
    g_id = category.id
    p_id = category.parent.id
    if p_id == 2 || p_id == 21 || p_id == 43 || p_id == 62 || p_id == 78 || p_id == 186 || p_id == 201 || p_id == 214 || p_id == 238 || p_id == 270 || g_id == 1045 || g_id == 1057
      @sizes = Size.where(id: 1..10)#服のサイズ
    elsif p_id == 248 || g_id == 1042 || g_id == 1053
      @sizes = Size.where(id: 11..26)#メンズ靴サイズ
    elsif p_id == 67 || g_id == 1043 || g_id == 1054
      @sizes = Size.where(id: 27..42)#レディース靴サイズ
    elsif p_id == 346 || p_id == 358 || p_id == 367
      @sizes = Size.where(id: 62..67)#ベビー服~95cmサイズ
    elsif p_id == 376 || p_id == 395 || p_id == 410 || g_id == 1047 || g_id == 1055
      @sizes = Size.where(id: 48..54)#キッズ服~100cmサイズ
    elsif p_id == 419 || g_id == 1055 || g_id == 1044
      @sizes = Size.where(id: 55..62)#キッズ・ベビー靴サイズ
    elsif g_id == 927
      @sizes = Size.where(id: 68..77)#テレビサイズ
    elsif g_id == 1234
      @sizes = Size.where(id: 90..95)#オートバイサイズ
    elsif g_id == 1254
      @sizes = Size.where(id: 96..103)#ヘルメットサイズ
    elsif p_id == 1201
      @sizes = Size.where(id: 104..116)#タイヤサイズ
    elsif g_id == 1052
      @sizes = Size.where(id: 117..123)#スキー板のサイズ
    elsif g_id == 1040
      @sizes = Size.where(id: 124..130)#スノーボードのサイズ
    end
      respond_to do |format|
        format.json
      end
  end

  def search
    @brand = Brand.all.where("name LIKE(?)", "%#{params[:keyword]}%")
    respond_to do |format|
      format.json
    end
  end
  

  def privacy_policy
  end
  
  def show
  end


  private 

  def product_params
    params.require(:product).permit(:name, :price, :text, :status, :stage, :delivery_responsivility, :delivery_way, :delivery_area, :delivery_day, :category_id, :brand_id, product_images_attributes: [:image, :id, :destroy])
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end

  def product_images_params
    params.require(:product_images).require(:"0").permit({images: []})
  end
  
end
