class ApplicationController < ActionController::Base
  #現在basic認証は別の方が作業しており、認証することができないため
  #応急処置として、コメントアウトしています
  # before_action :basic_auth

  # private

  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
  #   end
  # end
end
