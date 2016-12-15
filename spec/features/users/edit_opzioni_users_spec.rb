require 'rails_helper'

feature "ModificaOpzioniUtente", :type => :feature do
  it "L'utente deve essere loggato per poter modificare le proprie opzioni" do
    password = "123456789"
    u = create( :user, password: password, password_confirmation: password )

    visit edit_user_registration_path

    within "#new_user" do
      fill_in "user[email]", with: u.email
      fill_in "user[password]", with: password
    end

    click_button "Accedi"

    within "#edit_user" do
      fill_in "user[nome]", with: "Nome"
      fill_in "user[email]", with: "Email"
      choose('user_sesso_m')
      fill_in "user[current_password]", with: password
    end

    click_link_or_button "Modifica account"
    #Se tutto è andato a buon fine lo stato della pagina è 200

    expect(page.driver.status_code).to eq(200)
  end
end