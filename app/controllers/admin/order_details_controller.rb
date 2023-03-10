class Admin::OrderDetailsController < ApplicationController
  def top
   @orders= Order.all
  end

  def show
   @order= Order.find(params[:id])
  end

  def update
   @order_detail= OrderDetail.find(params[:id])
    @orders= Order.all
    if params[:order_detail][:making_status] == "production"
     @order_detail.update(order_detail_params)
      @orders.each do |order|
       order.status= "production"
        @orders.update(status: order.status)
      end
    end
    if params[:order_detail][:making_status] == "production_completed"
     @order_detail.update(order_detail_params)
      @orders.each do |order|
       order.status= "shipping_preparation"
        @orders.update(status: order.status)
      end
    end
    redirect_to admin_order_path(@order_detail.order)
  end


  private
  def order_detail_params
   params.require(:order_detail).permit(:making_status)
  end

end

