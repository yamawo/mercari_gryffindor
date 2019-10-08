class UsersController < ApplicationController

    def step3
        @user = User.new()
    end

    def step6
      @user = User.new
      @user.build_address
    end
    
end
