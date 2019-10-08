class UsersController < ApplicationController
    before_action :set_year, :set_month, :set_day
    
    def step3
        @user = User.new()
    end
    
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
end
