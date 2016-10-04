require 'test_helper'

class AnnouncementsControllerTest < ActionController::TestCase
  setup do
    @announcement = announcements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:announcements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create announcement" do
    assert_difference('Announcement.count') do
      post :create, announcement: { categoria: @announcement.categoria, descrizione: @announcement.descrizione, etichetta: @announcement.etichetta, foto: @announcement.foto, segnalato: @announcement.segnalato, titolo: @announcement.titolo, visite: @announcement.visite }
    end

    assert_redirected_to announcement_path(assigns(:announcement))
  end

  test "should show announcement" do
    get :show, id: @announcement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @announcement
    assert_response :success
  end

  test "should update announcement" do
    patch :update, id: @announcement, announcement: { categoria: @announcement.categoria, descrizione: @announcement.descrizione, etichetta: @announcement.etichetta, foto: @announcement.foto, segnalato: @announcement.segnalato, titolo: @announcement.titolo, visite: @announcement.visite }
    assert_redirected_to announcement_path(assigns(:announcement))
  end

  test "should destroy announcement" do
    assert_difference('Announcement.count', -1) do
      delete :destroy, id: @announcement
    end

    assert_redirected_to announcements_path
  end
end
