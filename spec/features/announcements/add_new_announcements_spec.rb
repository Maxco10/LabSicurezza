require 'rails_helper'

feature "AggiungiNuovaAnnuncio", :type => :feature do
  it "L'utente deve essere loggato per poter inserire l'annuncio" do
    password = "123456789"
    u = create( :user, password: password, password_confirmation: password )

    visit new_announcement_path

    within "#new_user" do
      fill_in "user[email]", with: u.email
      fill_in "user[password]", with: password
    end

    click_button "Accedi"

    within "#new_announcement" do
      fill_in "announcement[titolo]", with: "Titolo"
      #attach_file('announcement[foto]', Rails.root+'spec/annuncio5.jpg')
      select('Auto', :from => 'announcement[categoria]')
      fill_in "announcement[descrizione]", with: "Testo"
      fill_in "announcement[luogo]", with: "Via Roma"
    end

    click_link_or_button "Crea"
    #Se tutto è andato a buon fine lo stato della pagina è 200
    expect(page.driver.status_code).to eq(200)
  end
end