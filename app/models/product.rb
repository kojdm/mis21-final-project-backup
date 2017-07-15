class Product < ApplicationRecord
    has_many :order_lines, inverse_of: :product
    has_many :orders, through: :order_lines
    
    def activate!
        update_attribute :status, true
    end
    
    def deactivate!
        update_attribute :status, false
    end
end
