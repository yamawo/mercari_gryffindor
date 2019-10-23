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
  end

  def search_for
    @q = Product.search(search_params)
    @products = @q.result(distinct: true)
    # binding.pry
    @count = @products.count.to_s
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  private

  def search_params
    params.require(:q).permit(:name_cont)
  end

end
