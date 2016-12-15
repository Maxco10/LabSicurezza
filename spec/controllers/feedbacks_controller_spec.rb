require 'rails_helper'

RSpec.describe FeedbacksController, :type => :controller do
      
    describe "Un utente non loggato" do
        before :each do
            @user0 = create(:user)
            login_with nil
        end
        it "se cerca di vedere il feedback di un donatore particolare, vedrà i feedback dell'utente bersaglio" do
            get :index, utente: @user0.id
            expect( response ).to render_template(:index)
         end
    end 
    describe "un utente loggato" do
        before :each do
            
            @user100=create(:user)
            login_with @user100
            @user1000=create(:user)
        end
        it "se cerca di vedere il feedback di un utente particolare,potra farlo" do
            get :index, utente: @user1000.id
            expect(response).to render_template(:index)
        end
    end
end
