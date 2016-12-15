require 'rails_helper'

RSpec.describe Users::RegistrationsController, :type => :controller do
  describe "Un utente anonimo" do
        before :each do
          setup_controller_for_warden
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @my_user = nil    #Utente anonimo
          login_with @my_user
        end
        it "se cerca di accedere alle opzioni utente verrà reindirizzato alla pagina di login" do
          get :edit
          expect( response ).to redirect_to( new_user_session_path )
        end
  end

  describe "Un utente loggato" do
        before :each do
          setup_controller_for_warden
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @my_user = FactoryGirl.create(:user) # creo un utente valido
          login_with @my_user
        end
        it "se cerca di accedere alle opzioni utente, potrà farlo" do
          get :edit
          expect( response ).to render_template("users/registrations/edit")
        end
  end
end