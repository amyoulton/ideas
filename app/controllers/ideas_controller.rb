class IdeasController < ApplicationController

    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new(params.require(:idea).permit(:title, :description))
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
end
