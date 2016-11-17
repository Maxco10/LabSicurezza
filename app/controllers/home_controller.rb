class HomeController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
  
  #layout 'application'
  
  
  def presentazione
  end
  
  def profilo_utente
  end
  
  def risultati_ricerca
    #Funzione che si occupa della ricerca degli annunci.
    #Nei IF sottostanti descrimino se l'utente ha compilato o no, il campo bersaglio.
    #Perche in base ai campi riempiti decido che query fare su db.
    if params[:testo_cercato].empty?
      testo = true
    else
      testo = params[:testo_cercato]
    end
    if params[:categoria_cercata].empty?
      categoria = true
    else
      categoria = params[:categoria_cercata]
    end
    if params[:luogo_cercato].empty?
      luogo = true
    else
      luogo = params[:luogo_cercato]
    end
    
    #Ricerco utilizzando solo la stringa: l'utente ha compilato solo il campo testo
      if testo != true and categoria == true and luogo == true
          @announcements = Announcement.where('etichetta = 0 AND titolo LIKE ?', "%#{testo}%")
      #Ricerco utilizzando solo la categoria: l'utente ha compilato solo il campo categoria
      else if testo == true and categoria != true and luogo == true
          @announcements = Announcement.where('etichetta = 0 AND categoria = ?', "#{categoria}")
       #Ricerco utilizzando solo per luogo: l'utente ha compilato solo il campo luogo
      else if testo == true and categoria == true and luogo != true
          @announcements = Announcement.where('etichetta = 0 AND luogo LIKE ? ', "%#{luogo}%")
      #l'utente sta facendo una ricerca molto precisa in quanto ha compilato tutti e 3 i campi.
      else
          @announcements = Announcement.where('etichetta = 0 AND titolo LIKE ? AND categoria = ? AND luogo LIKE ?', "%#{testo}%", "#{categoria}", "#{luogo}")
      end
    end
  end
end

  def risultati_ricerca_categorie
    categoria_bersaglio=params[:categoria_bersaglio]
      
    if categoria_bersaglio=="motori"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Auto' OR categoria='Accessori moto' OR categoria='Moto' OR categoria='Accessori auto') ")
    elsif categoria_bersaglio=="elettrodomestici"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Elettrodomestici' OR categoria='Casalinghi' ) ")
    elsif categoria_bersaglio=="attrezzatura"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Attrezzatura da lavoro' OR categoria='Giardinaggio' OR categoria='Sport' ) ")
    elsif categoria_bersaglio=="telefonia"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Telefonia' ) ")
     elsif categoria_bersaglio=="informatica"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Informatica' ) ")
    elsif categoria_bersaglio=="elettronica"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Fotografia' OR categoria='Audio/video' OR categoria='Videogiochi') ")  
    elsif categoria_bersaglio=="abbigliamento"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Abbigliamento' ) ")
    elsif categoria_bersaglio=="case_persone"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Bambini' OR categoria='Mobili' OR categoria='Animali' OR categoria='Collezionismo' OR categoria='Cancelleria') ")  
     end  
   end
end