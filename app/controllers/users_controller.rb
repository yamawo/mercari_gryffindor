class UsersController < ApplicationController

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
