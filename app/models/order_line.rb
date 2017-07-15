class OrderLine < ApplicationRecord
  belongs_to :product, -> {where(status: true)}
  belongs_to :order
  
  validates :product, presence: true
  validates :quantity, presence: true
end
