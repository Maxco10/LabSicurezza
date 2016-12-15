require 'rails_helper'

feature "LogoutUtente", :type => :feature do
  it "L'utente deve essere loggato per poter sloggare" do
    password = "123456789"
    u = create( :user, password: password, password_confirmation: password )

    visit new_user_session_path

    within "#new_user" do
      fill_in "user[email]", with: u.email
      fill_in "user[password]", with: password
    end

    click_button "Accedi"
    click_link_or_button "Logout"
    
    #Se tutto è andato a buon fine lo stato della pagina è 200

    expect(page.driver.status_code).to eq(200)
  end
end