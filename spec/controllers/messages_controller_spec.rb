require 'rails_helper'

RSpec.describe MessagesController, :type => :controller do
  describe "Un utente anonimo" do
    before :each do
      login_with nil    #Login nullo, quindi è un utente anonimo
      @user0 = create(:user) #creo un utente0
      @user1 = create(:user) #creo un utente1
      @messaggio = Message.create!(titolo: 'Titolo', testo: 'Testo', mittente_id: @user0.id, destinatario_id: @user1.id, stato: 0)
    end
    it "se cerca di accedere ai messaggi verrà reindirizzato alla pagina di login" do
      get :index
      expect( response ).to redirect_to( new_user_session_path )
    end
    it "se cerca di accedere ai messaggi inviati verrà reindirizzato alla pagina di login" do
      get :index
      expect( response ).to redirect_to( new_user_session_path )
    end
    it "se apre lo show di un messaggio verrà reindirizzato alla pagina di login" do
      get :show, id: @messaggio 
      expect(response).to redirect_to( new_user_session_path )
    end
    it "se vuole eliminare un messaggio verrà reindirizzato alla pagina di login" do
      delete :destroy, id: @messaggio 
      expect(response).to redirect_to( new_user_session_path )
    end
  end
  describe "Un utente loggato" do
    before :each do
      @user = create(:user) #creo un utente di login
      login_with @user #L'utente registrato vedrà i suoi messaggi
      @user1 = create(:user) #creo un utente1
      @messaggio = Message.create!(titolo: 'Titolo', testo: 'Testo', mittente_id: @user.id, destinatario_id: @user1.id, stato: 0)
    end
    it "se cerca di accedere ai messaggi lo potrà fare" do
      get :index
      expect( response ).to render_template(:index)
    end
    it "se cerca di accedere ai messaggi inviati lo potrà fare" do
      get :messaggi_inviati
      expect( response ).to render_template("messages/messaggi_inviati")
    end
    it "se apre lo show di un messaggio vengono mostrate tutte le informazioni dell'messaggio" do
      get :show, id: @messaggio 
      expect(response).to render_template("messages/show")
    end
    it "se vuole eliminare un messaggio può farlo" do
      delete :destroy, id: @messaggio 
      expect(response).to redirect_to(messages_url)
    end
  end
end