class ProductsController < ApplicationController
  require 'payjp'
  before_action :redirect_login, except: [:index, :show, :category, :category_list]
  before_action :set_product, only: [:show, :destroy]

  def index
    require 'base64'
    ladies = Category.find_by(name: "レディース")
    @ladies = Product.where(category_id: ladies.indirects.ids).last(10).sort{|a,b| b <=> a}
    chanel = Brand.find_by(name: "シャネル")
    @chanel = Product.where(brand_id: chanel.id).last(10).sort{|a,b| b <=> a}
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
    binding.pry
    @product.save
    redirect_to controller: :products, action: :index
  end
  
  
  def edit
    @edit_product = Product.find(params[:id])
    gon.edit_product = @edit_product
    gon.edit_product_images = @edit_product.product_images

    # label用の変数
    @default_images = @edit_product.product_images.length
    gon.default_images = @default_images
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
    unless @edit_product.size_id.nil?
      @sizes = ["---"]
      sizes.each do |size|
        @sizes << [size.name, size.id]
      end
      size = @edit_product.size_id
      @size = Size.find(size)
    end
      if @edit_product.brand_id
      brand = @edit_product.brand_id
      @brand = Brand.find(brand)
    end
    respond_to do |format|
      format.json
      format.html
    end
    render layout: false
  end
  
  def update
    product = Product.find(params[:id])
    product.update(product_params)
  end
  
  def show
    @user = @product.user
    @products = @user.products
    array = []
    other_products = @products.limit(7)
    other_products.each do |product|
      array << product if product.id != params[:id].to_i
    end
    @array = array
  end

  def destroy
    if @product.user_id == current_user.id
       @product.destroy
    end
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

  def category
    require 'base64'
    @category = Category.find(params[:format])
    if @category.ancestry == nil
    @categories = Product.where(category_id: @category.indirects.ids)
    elsif @category.ancestry.match(/\//)
    @categories = Product.where(category_id: @category.id)
    else 
    @categories = Product.where(category_id: @category.children.ids)
    end
  end

  def category_list
    @parents = Category.where(ancestry: nil)
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
  
  def product_confirmation
    @product = Product.find(params[:product_id])
    if @product.status == 0
      @user = current_user
      @address = @user.address
      # テーブルからpayjpの顧客IDを検索
      card = Credit.find_by(user_id: current_user.id)
      if card.blank?
        # 登録された情報がない場合はカード登録画面に遷移
        redirect_to card_registration_form_users_path
      else
        Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
        # 保管した顧客IDでpayjpから情報取得
        customer = Payjp::Customer.retrieve(card.customer_id)
        # 保管したカードIDでpayjpから情報取得、カード情報表示のためにインスタンス変数に代入
        @default_card_information = customer.cards.retrieve(card.card_id)
        @exp_month = @default_card_information.exp_month.to_s
        @exp_year = @default_card_information.exp_year.to_s.slice(2,3)

        render layout: "users_layout"
      end
    else
      redirect_to root_path
    end
  end

  def product_pay
    @product = Product.find(params[:product_id])
    if @product.status == 0
      card = Credit.where(user_id: current_user.id).first
      Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
      Payjp::Charge.create(
        amount: @product.price, #todo あとでproductテーブルと紐づける
        customer: card.customer_id, #顧客ID
        currency: 'jpy' #日本円
      )
      redirect_to product_product_done_path
    else
      redirect_to root_path
    end
  end

  def product_done
     @product = Product.find(params[:product_id])
     @product.update(status: 1)
  end

  def privacy_policy
  end
  
  private 

  def product_params
    params.require(:product).permit(:name, :price, :text, :status, :stage, :delivery_responsivility, :delivery_way, :delivery_area, :delivery_day, :category_id, :brand_id, :size_id, :product_images, product_images_attributes: [:image, :id, :_destroy]).merge(user_id: current_user.id)
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_images_params
    params.require(:product_images).require(:"0").permit({images: []})
  end
  
  def redirect_login
    redirect_to new_user_session_path unless user_signed_in?
  end

end
