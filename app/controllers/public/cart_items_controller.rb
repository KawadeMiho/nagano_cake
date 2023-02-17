class Public::CartItemsController < ApplicationController

def index
  @cart_items= current_customer.cart_items
  @total_payment= 0
end

def update
  @cart_item = CartItem.find(params[:id])
  @cart_item.update(cart_item_params)
   redirect_to cart_items_path
end

def destroy
  @cart_item= CartItem.find(params[:id])
  @cart_item.destroy
  redirect_to cart_items_path
end

def destroy_all
  current_customer.cart_items.destroy_all
  redirect_to cart_items_path
end

def show
end

def create
  @cart_item = current_customer.cart_items.new(cart_item_params)
  @cart_item.customer_id= current_customer.id
  if cart_item_old =current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
     cart_item_old.amount += params[:cart_item][:amount].to_i
     cart_item_old.save
     redirect_to cart_items_path
  else @cart_item.save
     redirect_to cart_items_path
  end
end

def total_payment
 @cart_items.total_payment= (cart_item.item.price * 1.1).floor * cart_item.amount
end

private
 def cart_item_params
  params.require(:cart_item).permit(:item_id,:amount)
 end
end