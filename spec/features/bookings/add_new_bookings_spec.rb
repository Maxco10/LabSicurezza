require 'rails_helper'

feature "AggiungiPrenotazione", :type => :feature do
  it "L'utente deve essere loggato per poter prenotarsi ad un oggetto" do
    password = "123456789"
    u = create( :user, password: password, password_confirmation: password ) #utente di login
    u2 = create(:user)
    @annuncio = Announcement.create!(titolo: 'Titolo', descrizione: 'Testo descrizione', categoria: 'Auto', luogo: 'Roma',latitude: 0,longitude: 0, id_proprietario_id: u2.id)

    visit "announcements/#{@annuncio.id}"
    
    click_button "Devi accedere per prenotarti!"
    
    within "#new_user" do
      fill_in "user[email]", with: u.email
      fill_in "user[password]", with: password
    end

    click_button "Accedi"
    
    visit "announcements/#{@annuncio.id}"
    click_button "Prenotati"

    #Se tutto è andato a buon fine lo stato della pagina è 200
    expect(page.driver.status_code).to eq(200)
  end
end