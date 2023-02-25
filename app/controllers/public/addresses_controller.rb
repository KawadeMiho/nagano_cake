class Public::AddressesController < ApplicationController
  def index
   @addresses= current_customer.addresses
   @address = Address.new
  end

  def create
   @address= Address.new(address_params)
   @address.customer_id= current_customer.id
   @addresses = current_customer.addresses
   @address.save
   redirect_to addresses_path
  end


  def edit
   @address = Address.find(params[:id])
  end

  def update
   @address= Address.find(params[:id])
   @address.update(address_params)
   redirect_to address_path
  end

  def destroy
   @address = Address.find(params[:id])
   @address.destroy
   @addresses = current_customer.address
   redirect_to addresses_path
  end

  def address_params
   params.require(:address).permit(:name,:postal_code,:address,)
  end
end
