class Message < ActiveRecord::Base
  belongs_to :mittente, :class_name => 'User'
  belongs_to :destinatario, :class_name => 'User'
  
  def nome_mittente
    User.where("id = ?",mittente_id).take.nome
  end
  def nome_destinatario
    User.where("id = ?",destinatario_id).take.nome
  end
  
  
  
end
