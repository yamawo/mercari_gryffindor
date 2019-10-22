class ProductsController < ApplicationController
  before_action :find_product, only: [:show]

  def index
    ladies = Category.find_by(name: "レディース")
    @ladies = Product.where(category_id: ladies.indirects.ids).limit(10)
    chanel = Brand.find_by(name: "シャネル")
    @chanel = Product.where(brand_id: chanel.id).limit(10)
  end
  

  def new
    require "base64"
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

  def show
    @user = @product.user
    @products = @user.products
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
  
  def buy_confirmation
    # card = Credit.where(user_id: current_user.id).first
    # unless card.blank?
    #   Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
    #   customer = Payjp::Customer.retrieve(card.customer_id)
    #   @default_card_information = customer.cards.retrieve(card.card_id)
    #   @exp_month = @default_card_information.exp_month.to_s
    #   @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    # end
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

  def find_product
    @product = Product.find(params[:id])
  end

  def product_images_params
    params.require(:product_images).permit({images: []})
  end
  
  def privacy_policy
  end

end
