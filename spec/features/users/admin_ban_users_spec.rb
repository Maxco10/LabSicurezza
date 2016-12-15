require 'rails_helper'

feature "AdminBanUtente", :type => :feature do
  it "L'utente deve essere loggato e sopratutto avere i permessi da admin per poter bannare" do
    password = "123456789"
    u = create( :user, password: password, password_confirmation: password, tipo_utente: 1)

    visit new_user_session_path

    within "#new_user" do
      fill_in "user[email]", with: u.email
      fill_in "user[password]", with: password
    end

    click_button "Accedi"
    
    visit "listaUtenti"
    
    click_link_or_button "Banna"
    
    within "#ban" do
      fill_in "motivo", with: "Testo"
    end
    
    click_link_or_button "Banna"
    
    #Se tutto è andato a buon fine lo stato della pagina è 200
    expect(page.driver.status_code).to eq(200)
  end
end