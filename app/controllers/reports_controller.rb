class ReportsController < ApplicationController
before_action :authenticate_admin!

    def index
        @orders_all = Order.all
        @orders_today = Order.where("created_at >= ?", Time.zone.now.beginning_of_day)
        
        @products = Product.all
        @quantity_sold_for = {}
        
        @products.each do |product|
            @quantity_sold_for[product.name] = 0
        end
        
        @total_products_sold = 0
        
        @orders_today.each do |order|
            order.order_lines.each do |order_line|
                @quantity_sold_for[order_line.product.name] += order_line.quantity
                @total_products_sold += order_line.quantity
            end
        end
    end
    
end
