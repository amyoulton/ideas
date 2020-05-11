require "rails_helper"

RSpec.describe IdeasController, type: :controller do 
    
    def current_user 
        @current_user ||= FactoryBot.create(:user)
    end

    describe "#new" do
    context "without a signed in user" do 
        it "redirects user to log in page in not signed in" do 
            get :new 
            expect(response).to redirect_to(new_session_path)
        end
        it "danger flash if not signed in" do 
            get :new 
            expect(flash[:danger]).to be 
        end
    end
    end
    
    context "with a signed in user" do 
        before do 
            session[:user_id] = current_user.id 
        end

        it "renders the new template" do 
            get(:new)
            expect(response).to(render_template(:new))
        end
    end
end