class Genre < ApplicationRecord

  has_many :products

  validates :genre_name, presence: true

end
