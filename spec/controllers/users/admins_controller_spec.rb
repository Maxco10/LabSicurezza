require 'rails_helper'

RSpec.describe Users::AdminsController, :type => :controller do
  describe "Un utente anonimo" do
        before :each do
            login_with nil    #Login nullo, quindi è un utente anonimo
        end
        it "se cerca di visualizzare la ListaUtenti verrà reindirizzato alla pagina di login" do
          get :listaUtenti
          expect( response ).to redirect_to( new_user_session_path )
        end
        it "se cerca di visualizzare la ListaAnnunci verrà reindirizzato alla pagina di login" do
          get :listaAnnunci
          expect( response ).to redirect_to( new_user_session_path )
        end
        it "se cerca di visualizzare la ListaPrenotazione verrà reindirizzato alla pagina di login" do
          get :listaPrenotazioni
          expect( response ).to redirect_to( new_user_session_path )
        end
        it "se cerca di visualizzare la ListaAnnunciSegnalati verrà reindirizzato alla pagina di login" do
          get :annunciSegnalati
          expect( response ).to redirect_to( new_user_session_path )
        end
  end
  describe "Un utente loggato semplice" do
        before :each do
          @user = create(:user) #creo un utente
          login_with @user #L'utente registrato vedrà i suoi annunci aperti
        end
        it "se cerca di visualizzare la ListaUtenti verrà reindirizzato alla pagina di login" do
          get :listaUtenti
          expect( response ).to redirect_to( root_path )
        end
        it "se cerca di visualizzare la ListaAnnunci verrà reindirizzato alla pagina di login" do
          get :listaAnnunci
          expect( response ).to redirect_to( root_path )
        end
        it "se cerca di visualizzare la listaPrenotazioni verrà reindirizzato alla pagina di login" do
          get :listaPrenotazioni
          expect( response ).to redirect_to( root_path )
        end
        it "se cerca di visualizzare la listaAnnunciSegnalati verrà reindirizzato alla pagina di login" do
          get :annunciSegnalati
          expect( response ).to redirect_to( root_path )
        end
  end
  describe "Un utente loggato admin" do
        before :each do
          @user = create(:user, tipo_utente: 1) #creo un utente
          login_with @user #L'utente registrato vedrà i suoi annunci aperti
        end
        it "se cerca di visualizzare la ListaUtenti, potra farlo" do
          get :listaUtenti
          expect( response ).to render_template("users/admins/listaUtenti")
        end
        it "se cerca di visualizzare la ListaAnnunci, potra farlo" do
          get :listaAnnunci
          expect( response ).to render_template( "users/admins/listaAnnunci" )
        end
        it "se cerca di visualizzare la listaPrenotazioni, potra farlo" do
          get :listaPrenotazioni
          expect( response ).to render_template( "users/admins/listaPrenotazioni" )
        end
        it "se cerca di visualizzare la listaAnnunciSegnalati, potrà farlo" do
          get :annunciSegnalati
          expect( response ).to render_template( "users/admins/annunciSegnalati" )
        end
  end
end