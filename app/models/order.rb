class Order < ApplicationRecord

  belongs_to :member, optional: true
  has_many :order_products, dependent: :destroy

  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
  validates :shipping_price, :total_payment, numericality: { only_integer: true }
  validates :member_id, :address,:name, :shipping_price,
			  		:total_payment, :payment_method,
			  		presence: true

  enum payment_method: { クレジットカード: 0, 銀行振込: 1}
  enum status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}

end
