class ProductsController < ApplicationController
  before_action :valid_create, only: :create
  def index 
    @product = Product.new
  end
  
  def new
    require "base64"                          #バイナリーデータ化（しないとJSで画像表示できない）
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
    require "base64"                          #バイナリーデータ化（しないとJSで画像表示できない）
    @product = Product.new(product_params)    #保存できたかどうかで分岐させたいのでnew
    if @product.save
      redirect_to controller: :products, action: :index
    else
      render action: :new, layout: "selling"
    end
  end

  

  def edit
    require "base64"
    
    @edit_product = Product.find(params[:id])  # 既存のproductレコードを取得
    @id = @edit_product.id
    gon.product = @edit_product
    gon.edit_product_images = @edit_product.product_images
    gon.edit_product_images_binary_datas = []
    # FIXME binarydata化するしかないのか, gonを使わず保守性の高いスマートな書き方が出来ないか
    if Rails.env.production?
      client = Aws::S3::Client.new(
        region: "ap-northeast-1",
        access_key_id: Rails.application.credentials[:aws][:access_key_id],
        secret_access_key: Rails.application.credentials[:aws][:secret_access_key]
      )
      @edit_product.product_images.each do |image|
        binary_data = client.get_object(bucket: 'mercari-gryffindor', key: image.image.file.path).body.read
        gon.edit_product_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    else
      @edit_product.product_images.each do |image|
        binary_data = File.read(image.image.file.file)
        gon.edit_product_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    end
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
    size = @edit_product.size_id
    @size = Size.find(size)
    brand = @edit_product.brand_id
    @brand = Brand.find(brand)
    
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
    @update_product = Product.find(params[:id])
    
    #登録済み画像の配列を作成
    ids = @update_product.product_images.map{|image| image.id}
    #登録済み画像の内、編集後もまだ残っている画像のidの配列を生成（文字列から数値に変換作業）
    exist_ids = registered_image_params[:ids].map(&:to_i)
    #登録済み画像が残っていない場合（配列に０が格納されている）、配列を空にする
    exist_ids.clear if exist_ids[0] == 0
    
    if (exist_ids.length != 0 || new_image_params[:images][0] != " ") && @update_product.update(product_params)
      
      #登録済み画像の内、削除ボタンを押したものを削除
      unless ids.length == exist_ids.length
        #削除する画像のidの配列を生成
        delete_ids = ids - exist_ids
        delete_ids.each do |id|
          @update_product.product_images.find(id).destroy
        end
      end

      #新規画像があればcreate
      unless new_image_params[:images][0] == " "
        new_image_params[:images].each do |image|
          @update_product.product_images.create(image: image, product_id: @update_product.id)
        end
      end
    end
    redirect_to action: :index
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

  def selling_stage
    #商品情報
    @products = Product.all.order("id ASC")
    
  end

  private 

  def product_params
    params.require(:product).permit(:status, :name, :price, :text, :delivery_responsivility, :delivery_way, :delivery_area, :delivery_day, :category_id, :brand_id, :size_id, product_images_attributes: [:image, :id, :destroy]).merge(user_id: current_user.id)
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end

  def product_images_params
    params.require(:product).require(:product_image).permit(:image)
  end

  def valid_create
    session[:product_params] = product_params
    @product = Product.new(session[:product_params])
    @product = Product.new
    parents = Category.where(ancestry: nil)
    @parents = [["---", "---"]]
    @parent = "---"
    parents.each do |parent|
      @parents << [parent.name, parent.id]
    end
    
    @product.product_images.build
    render "layouts/selling" unless @product.valid?
    binding.pry
  end
  
end
