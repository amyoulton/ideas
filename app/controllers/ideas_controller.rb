class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] 
  before_action :authorize!, only: [:edit, :update, :destroy]

    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new(params.require(:idea).permit(:title, :description))
        @idea.user = current_user
        if @idea.save
            redirect_to ideas_path
          else
            render :new
          end
    end

    def index
          @ideas = Idea.all.order('updated_at DESC')  
    end

    def show
        id = params[:id]
        @idea = Idea.find(id)
        @review = Review.new 
        @reviews = @idea.reviews.order(created_at: :desc)
    
        @like = @idea.likes.find_by(user: current_user)
    end

    def edit
        id = params[:id]
        @idea = Idea.find(id)
    end

    def update
        id = params[:id]
        @idea = Idea.find(id)
        if @idea.update(params.require(:idea).permit(:title, :description))
          redirect_to idea_path(@idea)
        else
          render :edit
        end
    end

    def destroy
        id = params[:id]
        @idea = Idea.find(id)
        @idea.destroy
        redirect_to ideas_path
    end

    def authorize! 
      redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, Idea)
    end
end
