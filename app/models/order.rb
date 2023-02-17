class Order < ApplicationRecord
 enum payment_method: {credit_card: 0, transfer: 1 }
 enum status: {waiting: 0, confirmation: 1, production: 2, shipping_preparation: 3, shipped: 4 }

 belongs_to :customer
 has_many :order_details

 def subtotal
  item.with_tax_price * amount
 end
end
