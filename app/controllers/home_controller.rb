class HomeController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
  
  #layout 'application'
  
  Numero_risultati_per_pagina = 20
  
  def presentazione
    render layout: 'application'
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
      @announcements = Announcement.where('etichetta = 0 AND titolo LIKE ?', "%#{testo}%").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    #Ricerco utilizzando solo la categoria: l'utente ha compilato solo il campo categoria
    elsif testo == true and categoria != true and luogo == true
      @announcements = Announcement.where('etichetta = 0 AND categoria = ?', "#{categoria}").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    #Ricerco utilizzando solo per luogo: l'utente ha compilato solo il campo luogo
    elsif testo == true and categoria == true and luogo != true
      @announcements = Announcement.where('etichetta = 0 AND luogo LIKE ? ', "%#{luogo}%").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    #Ricerco utilizzando testo e categoria
    elsif testo != true and categoria != true and luogo == true
      @announcements = Announcement.where('etichetta = 0 AND titolo LIKE ? AND categoria = ?', "%#{testo}%","#{categoria}").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    #Ricerco utilizzando testo e luogo
    elsif testo != true and categoria == true and luogo != true
      @announcements = Announcement.where('etichetta = 0 AND titolo LIKE ? AND luogo LIKE ? ',"%#{testo}%", "%#{luogo}%").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    #Ricerco utilizzando categoria e luogo
    elsif testo == true and categoria != true and luogo != true
      @announcements = Announcement.where('etichetta = 0 AND categoria = ? AND luogo LIKE ? ',"#{categoria}", "%#{luogo}%").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    #l'utente sta facendo una ricerca molto precisa in quanto ha compilato tutti e 3 i campi.
    else
      @announcements = Announcement.where('etichetta = 0 AND titolo LIKE ? AND categoria = ? AND luogo LIKE ?', "%#{testo}%", "#{categoria}", "#{luogo}").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    end
    render layout: 'per_annunci'
  end

  def risultati_ricerca_categorie
    categoria_bersaglio=params[:categoria_bersaglio]
          #@announcements = Announcement.all.paginate(page: params[:page], per_page: 5)
    if categoria_bersaglio=="motori"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Auto' OR categoria='Accessori moto' OR categoria='Moto' OR categoria='Accessori auto') ").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    elsif categoria_bersaglio=="elettrodomestici"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Elettrodomestici' OR categoria='Casalinghi' ) ").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    elsif categoria_bersaglio=="attrezzatura"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Attrezzatura da lavoro' OR categoria='Giardinaggio' OR categoria='Sport' ) ").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    elsif categoria_bersaglio=="telefonia"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Telefonia' ) ").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    elsif categoria_bersaglio=="informatica"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Informatica' ) ").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    elsif categoria_bersaglio=="elettronica"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Fotografia' OR categoria='Audio/video' OR categoria='Videogiochi') ") .paginate(page: params[:page],per_page: Numero_risultati_per_pagina) 
    elsif categoria_bersaglio=="abbigliamento"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Abbigliamento' ) ").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    elsif categoria_bersaglio=="case_persone"
      @categoria=Announcement.where("(etichetta=0) AND (categoria='Bambini' OR categoria='Mobili' OR categoria='Animali' OR categoria='Collezionismo' OR categoria='Cancelleria') ").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    end
    render layout: 'per_annunci'
  end

end