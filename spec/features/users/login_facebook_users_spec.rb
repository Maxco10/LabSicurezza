require 'rails_helper'

feature "LoginConFacebook", :type => :feature do
  it "L'utente deve confermare l'autorizzazione per facebook login" do

    visit new_user_session_path


    click_link_or_button "Login con Facebook"
    #Se tutto è andato a buon fine lo stato della pagina è 200

    expect(page.driver.status_code).to eq(200)
  end
end