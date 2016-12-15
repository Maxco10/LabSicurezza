require 'rails_helper'

feature "ModificaPasswordUtente", :type => :feature do
  it "L'utente deve essere loggato per poter modificare la propria password" do
    password = "123456789"
    u = create( :user, password: password, password_confirmation: password )

    visit edit_user_registration_path

    within "#new_user" do
      fill_in "user[email]", with: u.email
      fill_in "user[password]", with: password
    end

    click_button "Accedi"

    within "#edit_user" do
      fill_in "user[password]", with: "nuova password"
      fill_in "user[password_confirmation]", with: "nuova password"
      fill_in "user[current_password]", with: password
    end

    click_link_or_button "Modifica account"
    #Se tutto è andato a buon fine lo stato della pagina è 200

    expect(page.driver.status_code).to eq(200)
  end
end