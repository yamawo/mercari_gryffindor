class UsersController < ApplicationController
  def mypage
  end
  def confirmation
    @address = Address.new
  end

end
