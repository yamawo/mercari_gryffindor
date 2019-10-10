class UsersController < ApplicationController
<<<<<<< HEAD
    before_action :set_year, :set_month, :set_day
    layout "users_layout"
    
    def step3
        @user = User.new()
    end
    
=======
  before_action :set_year, :set_month, :set_day

  def step3
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

>>>>>>> 31ec68f519d673754b5ace0e1e22c3f447bbefa9
    def step4
        @user = User.new()
    end

    def step6
      @user = User.new
      @user.build_address
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

  private

  def user_params
    params.permit(
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
      :nickname,
      :text,
      :image,
      :good,
      :normal,
      :bad,
      address_attributes: [
        :id,
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
