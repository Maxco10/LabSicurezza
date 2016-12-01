class Booking < ActiveRecord::Base
  belongs_to :annuncio
  belongs_to :proprietario
  belongs_to :prenotato
  
  def nome_proprietario
    User.where("id = ?",proprietario_id).take.nome
  end
  
  def nome_prenotato
    User.where("id = ?",prenotato_id).take.nome
  end
  
  def titolo_annuncio
    Announcement.where("id = ?",annuncio_id).take.titolo
  end
  
  def foto_annuncio
    Announcement.where("id = ?",annuncio_id).take.foto
  end
  
  def etichetta_annuncio
    Announcement.where("id = ?",annuncio_id).take.etichetta
  end
end
