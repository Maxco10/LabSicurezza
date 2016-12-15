require 'rails_helper'

RSpec.describe BookingsController, :type => :controller do
    describe "Un utente anonimo" do
    before :each do
      login_with nil    #Login nullo, quindi è un utente anonimo
      @user0 = create(:user)
      @user1 = create(:user)
      @annuncio = Announcement.create!(titolo: 'Titolo', descrizione: 'Testo descrizione', categoria: 'Auto', luogo: 'Roma',latitude: 0,longitude: 0, id_proprietario_id: @user0.id)
      @booking = Booking.create!(annuncio_id: @annuncio.id, proprietario_id: @user0.id, prenotato_id: @user1.id)
    end
    it "se cerca di accedere alle prenotazioni ricevute, verrà rendirizzato al login" do
        get :index
        expect( response ).to redirect_to( new_user_session_path )
    end
    it "se cerca di accedere alle prenotazioni inviate, verrà rendirizzato al login" do
        get :richieste_inviate
        expect( response ).to redirect_to( new_user_session_path )
    end
    it "se cerca di chiudere una prenotazione, verrà rendirizzato al login" do
        get :chiudi_annuncio
        expect( response ).to redirect_to( new_user_session_path )
    end
    it "se cerca di eliminare una prenotazione, verrà rendirizzato al login" do
        delete :destroy, id: @booking
        expect( response ).to redirect_to( new_user_session_path )
    end
    
  end
  describe "Un utente loggato" do
    before :each do
      @user = create(:user) #creo un utente di login
      login_with @user #L'utente registrato vedrà i suoi annunci aperti
      @user1 = create(:user)
      @annuncio = Announcement.create!(titolo: 'Titolo', descrizione: 'Testo descrizione', categoria: 'Auto', luogo: 'Roma',latitude: 0,longitude: 0, id_proprietario_id: @user.id)
      @booking = Booking.create!(annuncio_id: @annuncio.id, proprietario_id: @user.id, prenotato_id: @user1.id)
    end
    it "se cerca di accedere alle prenotazioni ricevute, potrà farlo" do
        get :index
        expect( response ).to render_template(:index)
    end
    it "se cerca di accedere alle prenotazioni inviate, potrà farlo" do
        get :richieste_inviate
        expect( response ).to render_template("bookings/richieste_inviate")
    end
    it "se cerca di chiudere una prenotazione, potrà farlo" do
        get :chiudi_annuncio, id: @booking.id
        expect( response ).to redirect_to( bookings_url )
    end
    it "se cerca di eliminare una prenotazione, potrà farlo" do
        delete :destroy, id: @booking
        expect( response ).to redirect_to( richieste_inviate_path )
    end
    
  end

end