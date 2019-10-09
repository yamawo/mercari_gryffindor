class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :edit

  # private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] && password == Rails.application.credentials[:basic_auth][:password]
    end
  end

  def edit
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
end
