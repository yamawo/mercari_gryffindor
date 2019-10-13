class UsersController < ApplicationController

  require "payjp"
  before_action :set_year, :set_month, :set_day
  before_action :validates_step3, only: :step4
  before_action :validates_step6, only: :step7
  layout "users_layout"

  def step3
    @user = User.new
  end

  def step4
    @user = User.new
    session[:user_params] = user_params
    
  end

  def step6
    session[:user_params][:phone_number] = user_params[:phone_number]
    @user = User.new
    @user.build_address
  end

  def step7
    @user = User.new
    session[:address_attributes1] = user_params[:address_attributes]
    puts session[:user_params]
  end

  def set_year
      years = []
      for year in 1900..2019 do
          years << year 
      end
      new_years = years.reverse
      @year = new_years
  end

  def set_month
    months = []
    for month in 1..12 do
        months << month
    end
    @month = months
  end

  def set_day
    days = []
    for day in 1..31 do
        days << day
    end
    @day = days
  end

  def step8
    @user = User.new(session[:user_params])
    @user.build_address(session[:address_attributes1])
    if @user.save
        session[:id] = @user.id
        # PayjpとCardのデータベースを作成
        Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]

        if params['payjp-token'].blank?
            redirect_to "/"
        else
            # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録する
            customer = Payjp::Customer.create(
                description: 'test', # 書かなくてもいい。PAY.JPの顧客情報に表示する概要
                email: @user.email,
                card: params['payjp-token'], # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐づけて永久保存する
                metadata: {user_id: @user.id}
            )
            @card = Credit.new(user_id: @user.id, customer_id: customer.id, card_id: customer.default_card)
            if @card.save
                sign_in User.find(session[:id]) unless user_signed_in?
            else
                render "/"
            end
        end
    else 
      render "/"
    end
  end

  def validates_step3
    session[:user_params] = user_params
    @user = User.new(session[:user_params])
    render "/users/step3" unless @user.valid?(:validates_step3)
  end

  def validates_step6
    session[:address_attributes1] = user_params[:address_attributes]
    @user = User.new(
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
    )
    @user.build_address(session[:address_attributes1])
    render "/users/step6" unless @user.valid?(:validates_step6)
    puts session[:user_params]
  end
  private

  def user_params
    params.require(:user).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :birthdate_year,
      :birthdate_month,
      :birthdate_day,
      :email,
      :phone_number,
      :password,
      :password_confirmation,
      :nickname,
      :text,
      :image,
      :good,
      :normal,
      :bad,
      address_attributes: [
        :id,
        :last_name,
        :first_name,
        :last_name_kana,
        :first_name_kana,        
        :postal_code,
        :address_prefecture,
        :address_city,
        :address_number,
        :address_building,
        :address_phone,
      ]
    )

  def profile
  end
    
  def mypage

  end

  def logout
    
  end
  
  def confirmation
    @address = Address.new
  end
    
end
