class Product < ApplicationRecord
  belongs_to :genre

  has_many :cart_products
  has_many :orders, through: :order_products
  has_many :order_products
  attachment :image
  default_scope -> { order(id: :desc) }

   validates :name, presence: true
   validates :explanation, presence: true
   validates :tax_out_price, presence: true
   validates :image, presence: true
   validates :genre_id, presence: true


# 検索用のメソッド定義(部分一致のみ)
  def self.search(keyword)
    where(["name like?","%#{keyword}%" ])
  end

end
