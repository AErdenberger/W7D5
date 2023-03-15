class SubsController < ApplicationController
    before_action :require_logged_in, only:[:edit, :update, :create]

    def index
    end

    def create
        #current user becomes moderator
    end

    def new

    end

    def edit
        @sub = Sub.find_by(id: params[:id])
        if current_user.id == @sub.moderator_id
            render :edit
        else
            flash.now[:errors] = ["You are not authorized to edit this subreddit"]
            render :show
        end
    end

    def show
    end

    def update
        @sub = Sub.find_by(id: params[:id])
    end

    private
    def is_moderator?
        #if the current user is moderator > active record query
        current_user.username == Sub.joins(:moderator).where("@currentuser.id = moderator_id")
    end

    def sub_params
        params.require(:sub).permit(:title)
    end
end
