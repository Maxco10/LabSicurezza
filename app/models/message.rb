class Message < ActiveRecord::Base
  belongs_to :mittente, :class_name => 'User'
  belongs_to :destinatario, :class_name => 'User'
  
  def nome_mittente
    if mittente_id != -1
      User.where("id = ?",mittente_id).take.nome
    else
      "Da sistema"
    end
  end
  
  def nome_destinatario
    if(destinatario_id != nil)
      utente_bersaglio = User.where("id = ?",destinatario_id).take
      if(utente_bersaglio != nil)
        utente_bersaglio.nome
      end
    else
      "--"
    end
  end
  
  def imposta_come_letto
    Message.where("id = ?",id).limit(1).update_all("stato = 1")
  end
  
  
  
end
