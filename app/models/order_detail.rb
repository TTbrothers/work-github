class OrderDetail < ApplicationRecord

 belongs_to :order
 belongs_to :item

 validates :item_id, :order_id, :amount, :price, presence: true
 validates :price, :amount, numericality: { only_integer: true }

 enum status: {"製作不可": 0,"製作待ち": 1,"製作中": 2,"製作完了": 3}
 def tax
  1.1 * item.price
 end
end
