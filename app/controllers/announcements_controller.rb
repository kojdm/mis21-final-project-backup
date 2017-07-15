class AnnouncementsController < ApplicationController
before_action :authenticate_admin!

    def index
        @announcements = Announcement.all
    end
    
    def new
        @announcement = Announcement.new
    end
    
    def show
        @announcement = Announcement.find(params[:id])
    end
    
    def create
        @announcement = Announcement.new(announcement_params)
        @announcement.admin = current_admin
        
        if @announcement.save
            redirect_to @announcement
        else
            render 'new'
        end
    end
    
    private
     def announcement_params
         params.require(:announcement).permit(:subject, :content)
     end
end
