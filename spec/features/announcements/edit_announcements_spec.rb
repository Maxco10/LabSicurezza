require 'rails_helper'

feature "ModificaAnnuncio", :type => :feature do
  it "L'utente deve essere loggato per poter modificare l'annuncio" do
    password = "123456789"
    u = create( :user, password: password, password_confirmation: password )
    @annuncio = Announcement.create!(titolo: 'Titolo', descrizione: 'Testo descrizione', categoria: 'Auto', luogo: 'Roma',latitude: 0,longitude: 0, id_proprietario_id: u.id)

    visit "announcements/#{@annuncio.id}/edit"

    within "#new_user" do
      fill_in "user[email]", with: u.email
      fill_in "user[password]", with: password
    end

    click_button "Accedi"

    within "#edit_announcement_#{@annuncio.id}" do
      fill_in "announcement[titolo]", with: "Titolo"
      #attach_file('announcement[foto]', Rails.root+'spec/annuncio5.jpg')
      select('Auto', :from => 'announcement[categoria]')
      fill_in "announcement[descrizione]", with: "Testo"
      fill_in "announcement[luogo]", with: "Via Roma"
    end

    click_link_or_button "Modifica annuncio"
    #Se tutto è andato a buon fine lo stato della pagina è 200
    expect(page.driver.status_code).to eq(200)
  end
end