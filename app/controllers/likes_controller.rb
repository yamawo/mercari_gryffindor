class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: @current_user.id, product_id: params[:product_id])
    @like.save
    @product = Product.find_by(id: @like.product_id)
    @like_count = Like.where(product_id: params[:product_id]).count
  end
  
  def delete
    @like = Like.find_by(user_id: @current_user.id, product_id: params[:product_id])
    @product = Product.find_by(id: @like.product_id)
    @like.destroy
    @like_count = Like.where(product_id: params[:product_id]).count
  end
end
