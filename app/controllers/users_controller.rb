class UsersController < ApplicationController
  before_action :set_year, :set_month, :set_day
  # before_action :validates_step3, only: :step4
  # before_action :validates_step6, only: :step7
  layout "users_layout"
    
  def step3
    @user = User.new
  end

  def step4 
    @user = User.new
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthdate_year] = user_params[:birthdate_year]
    session[:birthdate_month] = user_params[:birthdate_month]
    session[:birthdate_day] = user_params[:birthdate_day]
  end

  def step6
    @user = User.new
    @user.build_address
    # session[:postal_code] = user_params[:postal_code]
    # session[:address_prefecture] = user_params[:address_prefecture]
    # session[:address_city] = user_params[:address_city]
    # session[:address_number] = user_params[:address_number]
    # session[:last_name] = user_params[:last_name]
    # session[:first_name] = user_params[:first_name]
    # session[:last_name_kana] = user_params[:last_name_kana]
    # session[:first_name_kana] = user_params[:first_name_kana]
    # session[:address_building] = user_params[:address_building]
    # session[:address_phone] = user_params[:address_phone]
  end

    def step7
        @user = User.new()
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

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birthdate_year: session[:birthdate_year],
      birthdate_month: session[:birthdate_month],
      birthdate_day: session[:birthdate_day],
    )
    @user.build_address(user_params[:address_attributes])
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_user_path
    else 
      render "/"
    end   
  end

  def step8
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  def validates_step3
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthdate_year] = user_params[:birthdate_year]
    session[:birthdate_month] = user_params[:birthdate_month]
    session[:birthdate_day] = user_params[:birthdate_day]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birthdate_year: session[:birthdate_year],
      birthdate_month: session[:birthdate_month],
      birthdate_day: session[:birthdate_day],
      phone_number: "09012345678"
    )
    render "/users/step3" unless @user.valid?(:validates_step3)
  end

  def validates_step6
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:postal_code] = user_params[:postal_code]
    session[:address_prefecture] = user_params[:address_prefecture]
    session[:address_city] = user_params[:address_city]
    session[:address_number] = user_params[:address_number]
    @address = Address.new( 
      last_name: session[:last_name],
      first_name: session[:first_name],
      first_name_kana: session[:first_name_kana],
      last_name_kana: session[:last_name_kana],
      postal_code: session[:postal_code],
      address_prefecture: session[:address_prefecture],
      address_city: session[:address_city],
      address_number: session[:address_number]
    )
    puts @address.valid?
    unless @address.valid?
      @user = User.new
      @user.build_address
      render "/users/step6"
    end  
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
  end  
end
