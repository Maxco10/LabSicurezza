require 'rails_helper'

RSpec.describe AnnouncementsController, :type => :controller do
  describe "Un utente anonimo" do
    before :each do
      login_with nil    #Login nullo, quindi è un utente anonimo
      @user0 = create(:user)
      @annuncio = Announcement.create!(titolo: 'Titolo', descrizione: 'Testo descrizione', categoria: 'Auto', luogo: 'Roma',latitude: 0,longitude: 0, id_proprietario_id: @user0.id)
    end
    it "se cerca di accedere a 'I tuoi annunci' verrà reindirizzato alla pagina di login" do
      get :index
      expect( response ).to redirect_to( new_user_session_path )
    end
    it "se cerca di inserire un nuovo verrà reindirizzato alla pagina di login" do
      get :new
      expect( response ).to redirect_to( new_user_session_path )
    end
    it "se cerca di accedere a 'I tuoi annunci chiusi' verrà reindirizzato alla pagina di login" do
      get :storico_oggetti_regalati
      expect( response ).to redirect_to( new_user_session_path )
    end
    it "se apre lo show di annuncio vengono mostrate tutte le informazioni dell'annuncio" do
      get :show, id: @annuncio 
      expect(response).to render_template("announcements/show")
    end
    it "se tenta di modificare l'annuncio gli viene chiesto di fare il login" do
      get :edit, id: @annuncio 
      expect(response).to redirect_to(new_user_session_path)
    end
    it "se vuole eliminare un annuncio verrà reindirizzato alla pagina di login" do
      delete :destroy, id: @annuncio 
      expect(response).to redirect_to(new_user_session_path)
    end
    it "se vuole segnalare un annuncio verrà reindirizzato alla pagina di login" do
      get :segnala_annuncio, id: @annuncio 
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  describe "Un utente loggato" do
    before :each do
      @user = create(:user) #creo un utente
      login_with @user #L'utente registrato vedrà i suoi annunci aperti
      @annuncio = Announcement.create!(titolo: 'Titolo', descrizione: 'Testo descrizione', categoria: 'Auto', luogo: 'Roma',latitude: 0,longitude: 0, id_proprietario_id: @user.id)
    end
    it "se cerca di accedere a 'I tuoi annunci' vedra tutti i suoi annunci aperti etichetta = 0" do
      get :index
      expect( response ).to render_template(:index)
    end
    it "se cerca di accedere a 'I tuoi annunci chiusi' vedra tutti i suoi annunci chiusi etichetta = 1" do
      get :storico_oggetti_regalati
      expect( response ).to render_template("announcements/storico_oggetti_regalati")
    end
    it "se cerca di inserire un nuovo verrà reindirizzato alla pagina di 'Nuovo annuncio'" do
      get :new
      expect( response ).to render_template("announcements/new")
    end
    it "se apre lo show di annuncio vengono mostrate tutte le informazioni dell'annuncio" do
      get :show, id: @annuncio 
      expect(response).to render_template("announcements/show")
    end
    it "se vuole modificare un annuncio vengono mostrate tutte le informazioni dell'annuncio da modificare" do
      get :edit, id: @annuncio 
      expect(response).to render_template("announcements/edit")
    end
    it "se vuole eliminare un annuncio può farlo, poi verrà riportato alla sua lista annunci" do
      delete :destroy, id: @annuncio 
      expect(response).to redirect_to(announcements_url)
    end
    it "se vuole segnalare un annuncio può farlo, poi verrà riportato alla root" do
      get :segnala_annuncio, id: @annuncio 
      expect(response).to redirect_to(root_url)
    end
  end

end