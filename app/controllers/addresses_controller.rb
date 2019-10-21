class AddressesController < ApplicationController
  
  def update
    @address = Address.new(address_params)
    address = current_user.address
    address.update(address_params) if @address.valid?(:validate_confirmation)
    puts @address.errors.details
    redirect_back(fallback_location: root_path)
  end

  private

  def address_params
    params.require(:address).permit(
      :postal_code,
      :address_prefecture,
      :address_city,
      :address_number
    )
  end

end
