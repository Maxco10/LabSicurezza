require 'rails_helper'

feature "NuovoUtente", :type => :feature do
  it "L'utente deve essere unico all'interno della piattaforma" do


    visit new_user_registration_path

    within "#new_user" do
      fill_in "user[nome]", with: "Nome"
      fill_in "user[email]", with: "Email"
      choose('user_sesso_m')
      fill_in "user[password]", with: "Pass"
      fill_in "user[password_confirmation]", with: "Pass"
    end

    click_link_or_button "Crea il tuo account"
    #Se tutto è andato a buon fine lo stato della pagina è 200

    expect(page.driver.status_code).to eq(200)
  end
end