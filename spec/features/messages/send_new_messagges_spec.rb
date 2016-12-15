require 'rails_helper'

feature "InviareUnMessaggio", :type => :feature do
  it "L'utente deve essere loggato per poter inviare un messaggio" do
    password = "123456789"
    u = create( :user, password: password, password_confirmation: password )
    u1 = create(:user)
    
    visit new_message_path(:destinatario_id => u1.id)
    
    within "#new_user" do
      fill_in "user[email]", with: u.email
      fill_in "user[password]", with: password
    end

    click_button "Accedi"
    
    within "#new_message" do
      fill_in "message[titolo]", with: "Titolo"
      fill_in "message[testo]", with: "Testo"
    end

    click_link_or_button "INVIA"
    #Se tutto è andato a buon fine lo stato della pagina è 200
    expect(page.driver.status_code).to eq(200)
  end
end