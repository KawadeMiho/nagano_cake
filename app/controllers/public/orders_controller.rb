class Public::OrdersController < ApplicationController
 def new
  @order= Order.new
 end

 def index
  @orders= current_customer.orders
 end

 def show
  @order_details = OrderDetail.where(order_id: params[:id])
  @order= Order.find(params[:id])
 end

 def create
  @order= Order.new(order_params)
  @cart_items= current_customer.cart_items.all
  @order.save
  @cart_items.each do |cart_item|
   @order_details = OrderDetail.new
   @order_details.order_id = @order.id
   @order_details.item_id = cart_item.item.id
   @order_details.purchas_price = cart_item.item.with_tax_price
   @order_details.amount = cart_item.amount
   @order_details.making_status = 0
   @order_details.save!
  end
  @cart_items.destroy_all
  redirect_to complete_path
 end

 def complete
 end

 def confirm
  @cart_items= current_customer.cart_items
  @order = Order.new(order_params)
  @order.shipping_cost =800
  @total_payment =0
  if params[:order][:order_address] == "0"
   @order.postal_code = current_customer.postal_code
   @order.address = current_customer.address
   @order.name = current_customer.last_name + current_customer.first_name
  elsif params[:order][:order_address] == "1"
   @address= Address.find(params[:order][:address_id])
   @order.postal_code = @address.postal_code
   @order.address = @address.address
   @order.name = @address.name
  elsif params[:order][:order_address] == "2"
   @order.postal_code = params[:order][:postal_code]
   @order.address = params[:order][:address_id]
   @order.name = params[:order][:name]
  end
   @order.status = 0
 end

 private
 def order_params
  params.require(:order).permit(:payment_method,:postal_code, :address, :name, :customer_id, :shipping_cost, :total_payment, :status)
 end
end
