class ProductsController < ApplicationController
before_action :authenticate_admin!

    def index
        @products = Product.all
    end
    
    def new
       @product = Product.new 
    end
    
    def show
        @product = Product.find(params[:id])
    end
    
    def edit
        @product = Product.find(params[:id])
    end
    
    def update
        @product = Product.find(params[:id])
        
        if @product.update(product_params)
            redirect_to @product
        else
            render 'edit'
        end
    end
    
    def deactivate
        @product = Product.find(params[:id])
        @product.deactivate!
        
        redirect_to products_path
    end
    
    def activate
        @product = Product.find(params[:id])
        @product.activate!
        
        redirect_to products_path
    end
    
    def create
        @product = Product.new(product_params)
        
        if @product.save
            redirect_to @product
        else
            render 'new'
        end
    end
    
    private
        def product_params
            params.require(:product).permit(:name, :price, :status)
        end
end
