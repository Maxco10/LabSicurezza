class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  
  
  has_many :announcements
  has_many :bookings
  has_many :feedbacks
  
  
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email    = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def conta_nuove_richieste
    Message.where(destinatario_id: id, stato: 0, mittente_id: -1).count
  end
  
  def conta_nuovi_messaggi
    Message.where("destinatario_id = ? and stato = ? and mittente_id != ? ", id,0,-1).count
  end
  
  def oggetti_del_proprietario
    Announcement.where("id_proprietario_id = ? and not etichetta = 2", id)
  end
  
  def storico_oggetti_regalati
    Announcement.where("id_proprietario_id = ? and etichetta = 2", id)
  end
  
  def nome_del_destinatario(id)
    if(id != nil)
      utente_bersaglio = User.where("id = ?",id).take
      if(utente_bersaglio != nil)
        utente_bersaglio.nome
      end
    else
      "--"
    end
  end

end
