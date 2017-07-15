class Order < ApplicationRecord
  belongs_to :user
  
  has_many :order_lines, inverse_of: :order
  has_many :products, through: :order_lines
  
  attr_accessor :current_step
  
  accepts_nested_attributes_for :order_lines, allow_destroy: true, reject_if: ->(attrs) {attrs['quantity'].blank?}
  accepts_nested_attributes_for :products
  
  validates :order_lines, presence: true
  validates :cash, presence: true, numericality: {greater_than: :total_price}, if: lambda { |o| o.current_step == "summary" }
  
  def calculate_change(total_price, cash)
    return cash - total_price
  end
  
  def steps
    %w[choice summary]
  end
  
  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
