# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  layout "users_layout"

  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @user = User.find_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #after_sign_in_path_forと同じパス
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      @year = User.set_year()
      @month = User.set_month()
      @day = User.set_day()
      render "users/facebook_step3"
    end
  end

  def failure
    redirect_to root_path and return
  end
# def facebook

#   if request.env['omniauth.auth'].info.email.blank?
#     redirect_to '/users/auth/facebook?auth_type=rerequest&scope=email'
#   end

#   # User.from_omniauthはModel側で実装
#   user = User.from_omniauth(request.env['omniauth.auth'])

#     # すでにuserが登録済みかの判定
#     if user
#       # 登録済みならログイン
#       sign_in_and_redirect user, event: :authentication
#       set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
#     else
#       # 新規登録用にセッションに必要情報を格納
#       if (data = request.env['omniauth.auth']['extra']['raw_info'])
#         session['devise.omniauth_data'] = {
#             email: data['email'],
#             name: data['name'],
#             facebook_uid: data['id']
#         }
#       endect_to new_user_registration_url
#     end
#   end

#   def failure
#     redirect_to root_path
#   end
# end
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
