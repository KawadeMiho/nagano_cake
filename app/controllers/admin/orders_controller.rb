class Admin::OrdersController < ApplicationController
  def show
   @order= Order.find(params[:id])
   @order_details= @order.order_details

  end

  def update
   @order= Order.find(params[:id])
    @order_details= @order.order_details
    if params[:order][:status] == "confirmation"
     @order.update(order_params)
      @order_details.each do |order_detail|
       order_detail.making_status= "waiting_for_production"
       @order_details.update(making_status: order_detail.making_status)
        redirect_to admin_order_path(@order)
      end
    end
  end


private
def order_params
 params.require(:order).permit(:name,:create_at,:address,:payment_method,:status)
end

end