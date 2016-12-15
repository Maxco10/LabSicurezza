class Booking < ActiveRecord::Base
  belongs_to :annuncement
  belongs_to :proprietario
  belongs_to :prenotato
  
  
  def nome_proprietario
    User.where("id = ?",proprietario_id).take.nome
  end
  
  def nome_prenotato
    @user = User.where("id = ?",prenotato_id).take
    if @user != nil
      @user.nome
    end
  end
  
  def titolo_annuncio
    @announcemet = Announcement.where("id = ?",annuncio_id).take
    if @announcemet != nil
      @announcemet.titolo
    end
  end
  
  def foto_annuncio
    @announcemet = Announcement.where("id = ?",annuncio_id).take
    if @announcemet != nil
      @announcemet.foto
    end
  end
  
  def etichetta_annuncio
    @announcemet = Announcement.where("id = ?",annuncio_id).take
    if @announcemet != nil
      @announcemet.etichetta
    end
  end
end
