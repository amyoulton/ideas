require "rails_helper"

RSpec.describe IdeasController, type: :controller do 
    
    # Adding a fake user for the purpose of authentication tests
    def current_user 
        @current_user ||= FactoryBot.create(:user)
    end

    # Below are the 2 tests required for the 'new' method in the idea controller
    # Additionally added tests to allow for user authentication

    describe "#new" do

    context "with a signed in user" do 
        # autheticates the signed in user to allow the original user tests to happen
        before do 
            session[:user_id] = current_user.id 
        end

        # the following are the original two tests required for the new method in the idea controller

        # that the new method correctly renders the new template 
        it "renders the new template" do 
            get(:new)
            expect(response).to(render_template(:new))
        end


        # checks that the idea variable (@idea) in the new method in the idea controller is assigned to Idea.new
        it "sets the idea variable" do 
            get(:new)
            expect(assigns(:idea)).to(be_a_new(Idea))
        end
    end

        # checks that the user authentication
    context "without a signed in user" do 

        # checks if a non-logged in user gets redirected to the sign in page
        it "redirects user to log in page in not signed in" do 
            get :new 
            expect(response).to redirect_to(new_session_path)
        end

        # checks if they non-logged in user gets the warning that "You need to be signed in first!" we created
        # in the authenticate user method in application_controller
        it "danger flash if not signed in" do 
            get :new 
            expect(flash[:danger]).to be 
        end
    end

    end


    # below are the 4 tests needed to check for the create method in the idea controller

    describe "#create" do 
   
    # the check to make sure that user authentication works
    # if the user is authenticated, the original tests for the create method will work correctly
    context "with signed in user" do 
        
        before do 
            session[:user_id] = current_user.id 
        end

        # I have done two tests to check for valid parameters
        context "with valid parameters" do 
    
            # this is fake form data to make sure the create method is working correctly
            def valid_request 
                post(:create, params: { idea: FactoryBot.attributes_for(:idea) })
            end

             it "creates an idea in the database" do 
                count_before = Idea.count
                valid_request
                count_after = Idea.count 
                expect(count_after).to(eq(count_before + 1))
             end

            it "correct redirection to the show page " do 
                valid_request
                expect(response).to(redirect_to(ideas_path))
            end

        end

        # I have done two tests to check for invalid paramters
        context "with invalid parameters" do 
            def invalid_request 
                post(:create, params: { idea: FactoryBot.attributes_for(:idea, title: nil) })
            end
    
            it "if it doesn't save in the database" do
                count_before = Idea.count 
                invalid_request 
                count_after = Idea.count 
                expect(count_after).to eq(count_before)
            end
    
            it "if it doesn't save it renders the new template" do 
                invalid_request
                expect(response).to render_template(:new)
            end
        end

    end

    # the tests I added to make sure that the create method responds correctly with unsuccessful user authentication
   
    context "without a signed in user" do 

        context "with valid parameters" do 
            def valid_request 
                post(:create, params: { idea: FactoryBot.attributes_for(:idea) })
            end
        # essentially these are the same tests we ran for a failure in the new tests but under create tests
        it "redirects to the log in page" do 
            valid_request 
            expect(response).to redirect_to(new_session_path)
        end

        it "danger flash if not signed in" do 
            valid_request
            expect(flash[:danger]).to be 
        end
    end
    end
end
end