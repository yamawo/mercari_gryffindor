class UsersController < ApplicationController

  require "payjp"
  after_action :sns_create, only: :step8
  before_action :set_year, :set_month, :set_day
  before_action :validates_step3, only: :step4
  before_action :validates_step4, only: :step6
  before_action :validates_step6, only: :step7
  
  layout "users_layout"
  
  def step3
    @user = User.new
  end
  
  def step4
    session[:user_params] = user_params
    @user = User.new
  end
  
  def step6
    session[:user_params][:phone_number] = user_params[:phone_number]
    @user = User.new
    @user.build_address
  end
  
  def step7
    @user = User.new
    session[:address_attributes1] = user_params[:address_attributes]
    render layout: "users_layout"
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

  def sns_create
    unless session[:sns_data].nil?
      session[:sns_data][:user_id] = @user.id
      SnsCredential.create(session[:sns_data])
    end
  end

  def profile
  end

  def mypage
  end

  def logout
  end

  def confirmation
    @address = Address.new
  end

  def card_registration_form
    @card = Credit.new
  end

  def card_registration_create #PayjpとCardのデータベースを作成
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]

    if params['payjp-token'].blank?
      redirect_to action: "card_registration_form"
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録する
      customer = Payjp::Customer.create(
        description: "test",
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @card = Credit.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "card_registration"
      else
        redirect_to aciton: "card_registration_create"
      end
    end
  end

  def card_registration
    card = current_user.credit
    unless card.blank?
      Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    end  
  end

  def card_delete #PayjpとCardデータベースを削除します
    card = current_user.credit
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    card.delete
    redirect_to action: "card_registration"
  end

  private
  
  def validates_step3
    session[:user_params] = user_params
    @user = User.new(session[:user_params])
    if params[:sns_authentication] == "on"
      render "/users/facebook_step3" unless @user.valid?(:validates_step3) && verify_recaptcha
    else
      render "/users/step3" unless @user.valid?(:validates_step3) && verify_recaptcha
    end
  end

  def validates_step4
    session[:user_params][:phone_number] = user_params[:phone_number]
    @user = User.new(session[:user_params])
    render "users/step4" unless @user.valid?(:validates_step4)
  end

  def validates_step6
    session[:address_attributes1] = user_params[:address_attributes]
    @user = User.new(
      email: session[:user_params]["email"],
      password: session[:user_params]["password"],
      password_confirmation: session[:user_params]["password_confirmation"],
    )
    @user.build_address(session[:address_attributes1])
    render "/users/step6" unless @user.valid?(:validates_step6)
  end

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
  end
end
