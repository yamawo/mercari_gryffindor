class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters , if: :devise_controller?
  before_action :basic_auth, if: :production?
  before_action :search_product
  
  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] && password == Rails.application.credentials[:basic_auth][:password]
    end
  end

  def search_product
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
    @category = Category.where(ancestry: nil)
  end

  def search_for
    @q = Product.search(search_params)
    @products = @q.result(distinct: true)
    @count = @products.count.to_s
  end

  def select_search
    if search_params[:category_id_eq].present? && search_params[:category_id_eq] != "0"
      # binding.pry
      q = Category.find(search_params[:category_id_eq]) 
      q_indirects = q.indirects
      q_children = q.children
      session[:search_params] = search_params
      session[:search_params].delete(:category_id_eq)
      if q_indirects.present?
        session[:search_params][:category_id_eq_any] = q_indirects.ids
      elsif q_children.present?
        session[:search_params][:category_id_eq_any] = q_children.ids
      else
        session[:search_params][:category_id_eq_any] = q.id
      end
    end
    @q = Product.ransack(session[:search_params])
    @products = @q.result(distinct: true)
    @count = @products.count.to_s
    render "application/search_for"
  end




  def search_form_lv2
   @category = Category.find_by(id: params[:id])
   @category_children_id = @category.children
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  private

  def search_params
    params.require(:q).permit(:name_cont, :category_id_eq)
  end

  def application
  end
end
