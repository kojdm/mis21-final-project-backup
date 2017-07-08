class UsersController < ApplicationController
    
    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end
        
    def show
        @user = User.find(params[:id])
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        
        if params[:user][:password].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
        end
        
        if @user.update(user_params)
          redirect_to @user
        else
          render 'edit'
        end
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        
        redirect_to users_path
    end
    
    def create
        @user = User.new(user_params)
        @user.admin = current_admin

        if @user.save
          redirect_to @user
        else
          render 'new'
        end
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation, :status)
        end
end
