require "rails_helper"

feature "nuovoFeedback", :type => :feature  do
    it "l'utente loggato sta lasciando un feedback" do
        password="123456789"    
        user0 = create(:user,password: password, password_confirmation: password) #utente di login 
        user1 = create(:user) #utente proprietatrio dell'annuncio
        #user1 ha concluso la transazione con user0 premendon sul bottone chiudi ,abilitando user0 a lasciare il feedback
        annuncio = Announcement.create!(titolo: 'Titolo', descrizione: 'Testo descrizione', categoria: 'Auto', luogo: 'Roma',latitude: 0,longitude: 0, id_proprietario_id: user1.id, etichetta:2)
        #prenotazione che lega  l'annuncio user0 e user1
        booking0 = Booking.create!(annuncio_id: annuncio.id, proprietario_id: user1.id, prenotato_id: user0.id)

        visit new_user_session_path
        within "#new_user" do
            fill_in "user[email]", with: user0.email 
            fill_in "user[password]", with: password
        end
        click_button "Accedi"
        
        visit richieste_inviate_path
        
        click_link "Lascia feedback"
        
        
        expect(page.driver.status_code).to eq(200)

        
    end
    


end