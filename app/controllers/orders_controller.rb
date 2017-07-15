class OrdersController < ApplicationController
before_action :authenticate_user!

    def index
        @orders = Order.where(user: current_user)
        @orders_today = @orders.where("created_at >= ?", Time.zone.now.beginning_of_day)
    end
    
    def new
        session[:order_params] ||= {}
        @order = Order.new(session[:order_params])

        @order.current_step = "choice"
        @order.order_lines.build
    end
    
    def create
        session[:order_params].deep_merge!(order_params) if order_params
        @order = Order.new(session[:order_params])
        @order.user = current_user
        
        @orders = Order.where(user: current_user)
        @orders_today = @orders.where("created_at >= ?", Time.zone.now.beginning_of_day)
        this_order_count = @orders_today.count + 1
        
        
        if @order.valid?
            if params[:back_button]
                @order.current_step = "choice"
            elsif params[:to_show]
                @order.total_price = perform_computations(@order, this_order_count)
                @order.save if @order.all_valid?
            elsif params[:to_summary]
                @order.total_price = perform_computations(@order, this_order_count)
                @order.current_step = "summary"
            end
        else
            if params[:to_summary]
                @order.current_step = "choice"
                @order.order_lines.build
            elsif params[:to_show]
                @order.current_step = "summary"
            end
        end
        
        if @order.new_record?
            render 'new'
        else
            @order.current_step = "choice"
            session[:order_params] = nil
            flash[:notice] = "Order saved."
            redirect_to @order
        end
    end
    
    def show
        @order = Order.find(params[:id])
        order_id = @order.id
        @order_lines = OrderLine.where(order_id: order_id)
    end
    
    def perform_computations(order, orders_count)
        total = 0
                
        if orders_count % 10 == 0
            order.is_discounted = true
            order.order_lines.each do |ol|
                ol.price = ol.product.price * ol.quantity * 0.9
                total += ol.price
            end
        else
           order.order_lines.each do |ol|
                ol.price = ol.product.price * ol.quantity
                total += ol.price
            end
        end
        
        return total
    end
    
    private
        def order_params
            params.require(:order).permit!
        end
end
