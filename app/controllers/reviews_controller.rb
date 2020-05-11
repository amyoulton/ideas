class ReviewsController < ApplicationController
    def create 
        @idea = Idea.find(params[:idea_id])
        @review = Review.new review_params
        @review.idea = @review
        @review.user = current_user
        if @review.save
            redirect_to review_path(@review)
        else
            @review = @idea.reviews.order(created_at: :desc)
            render 'idea/show'
        end
    end

    def destroy 
        @review = Review.find params[:id]
        if can?(:crud, @review)
            @review.destroy 
            redirect_to idea_path(@review.idea)
        else 
            head :unauthorized
        end
    end
    
    private 
    
    def review_params 
        params.require(:review).permit(:body, :rating)
    end
end
