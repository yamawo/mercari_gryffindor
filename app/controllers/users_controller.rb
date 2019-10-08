class UsersController < ApplicationController

    def step6
      @user = User.new
      @user.build_address
    end
    
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
end
