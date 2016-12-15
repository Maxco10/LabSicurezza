require 'rails_helper'

RSpec.describe Users::SessionsController, :type => :controller do
  describe "Un utente anonimo" do
        before :each do
          setup_controller_for_warden
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @my_user = nil    #Utente anonimo
          login_with @my_user
        end
        it "se cerca di fare il logout verrà reindirizzato alla pagina di login" do
          delete :destroy
          expect( response ).to redirect_to( root_path )
        end
  end

  describe "Un utente loggato" do
        before :each do
          setup_controller_for_warden
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @my_user = FactoryGirl.create(:user) # creo un utente valido
          login_with @my_user
        end
        it "se cerca di fare il logout potrà farlo" do
          delete :destroy
          expect( response ).to redirect_to( root_path )
        end
  end
  describe "OmniAuth facebook" do
    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end
  
    it "impostazione delle variabili di sessione per facebook" do
      expect(request.env["omniauth.auth"]['uid']).to eq('224682091293960')
    end
  end
  describe "Un utente bannato" do
        before :each do
          setup_controller_for_warden
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @my_user = FactoryGirl.create(:user, ban: 1) # creo un utente valido bannato
          login_with @my_user
        end
        it "se cerca di fare il login verrà reindirizzato alla home page" do
          get :new
          expect( response ).to render_template(root_path)
        end
  end
end