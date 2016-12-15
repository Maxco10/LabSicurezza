class Users::AdminsController < ApplicationController
    before_filter :authenticate_user!,:sei_admin
    Numero_risultati_per_pagina = 10
    
    def listaUtenti
        @users = User.all.paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    end
    def listaAnnunci
        @announcements = Announcement.all.paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    end
    
    def listaPrenotazioni
        @bookings = Booking.all.paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    end
    
    def faiAdmin
        User.where("id = #{params[:id]}").limit(1).update_all("tipo_utente = #{params[:admin]}")
        respond_to do |format|
                format.html { redirect_to listaUtenti_path, notice: 'Livello utente modificato!' }
                format.json { head :no_content }
        end
    end
    
    def modificaUtente_show
        @user = User.find(params[:id])
        render layout: "per_annunci"
    end
    
    def modificaUtente_update
            @utente_bersaglio = User.find(params[:user][:id])
            uploaded_io = params[:user][:foto]
            if uploaded_io != nil
                if @utente_bersaglio.foto != ""
                    file_veccchio = @utente_bersaglio.foto.split('/')[-1]
                    File.delete(Rails.root.join('app','assets','images','foto_utenti', "#{file_veccchio}"))
                end
                estensione = uploaded_io.original_filename.split('.')[-1]
                File.open(Rails.root.join('app','assets','images','foto_utenti', "utente#{@utente_bersaglio.id}.#{estensione}"), 'wb') do |file|
                    file.write(uploaded_io.read)
                end
                @utente_bersaglio.foto = "foto_utenti/utente#{@utente_bersaglio.id}.#{estensione}"
                #Usa questa query per il cambio foto 
                User.where("id = #{params[:user][:id]}").limit(1).update_all("foto = 'foto_utenti/utente#{@utente_bersaglio.id}.#{estensione}' ")
            end
            if params[:user][:password] != ""
                    pepper = nil
                    new_pw = ::BCrypt::Password.create("#{params[:user][:password]}#{pepper}", :cost => 10).to_s
                    User.where("id = #{params[:user][:id]}").limit(1).update_all("nome = '#{params[:user][:nome]}', email='#{params[:user][:email]}', sesso='#{params[:user][:sesso]}', encrypted_password='#{new_pw}' ")
            else
                    User.where("id = #{params[:user][:id]}").limit(1).update_all("nome = '#{params[:user][:nome]}', email='#{params[:user][:email]}', sesso='#{params[:user][:sesso]}'")
            end
    end
    
    def modificaAnnuncio_show
        @announcement = Announcement.find(params[:id])
        render layout: "per_annunci"
    end
    def modificaAnnuncio_update
        uploaded_io = params[:announcement][:foto]
        @announcement = Announcement.find(params[:announcement][:id])
        if uploaded_io != nil
            #Rails.logger.debug "#{params[:announcement].inspect}"
            if @announcement.foto != ""
              file_veccchio = @announcement.foto.split('/')[-1]
              File.delete(Rails.root.join('app','assets','images','foto_annunci', "#{file_veccchio}"))
            end
            estensione = uploaded_io.original_filename.split('.')[-1]
            File.open(Rails.root.join('app','assets','images','foto_annunci', "annuncio#{@announcement.id}.#{estensione}"), 'wb') do |file|
                file.write(uploaded_io.read)
            end
            Announcement.where("id = #{params[:announcement][:id]}").limit(1).update_all("foto = 'foto_annunci/annuncio#{@announcement.id}.#{estensione}' ")
        end
        Announcement.where("id = #{params[:announcement][:id]}").limit(1).update_all("titolo='#{params[:announcement][:titolo]}',categoria='#{params[:announcement][:categoria]}',luogo='#{params[:announcement][:luogo]}',descrizione='#{params[:announcement][:descrizione]}'")
    end
    
    def chiudiAnnuncio
        @announcement = Announcement.find(params[:id])
        Announcement.where("id = ?",@announcement.id).limit(1).update_all("etichetta = 2")
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'Annuncio chiuso!' }
          format.json { head :no_content }
        end
    end
    def apriAnnuncio
        @announcement = Announcement.find(params[:id])
        Announcement.where("id = ?",@announcement.id).limit(1).update_all("etichetta = 0")
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'Annuncio riaperto!' }
          format.json { head :no_content }
        end
    end
    
    
    def annunciSegnalati
        @announcements = Announcement.where("segnalato = 1").paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    end
    def togliSegnalato
            @announcement = Announcement.find(params[:id])
            Announcement.where("id = ?",@announcement.id).limit(1).update_all("segnalato = 0")
            respond_to do |format|
              format.html { redirect_to annunciSegnalati_url, notice: 'Annuncio tolto da segnalato!' }
              format.json { head :no_content }
            end
    end
    
    def banna_show
    end
    
    def banna_action
        User.where("id = #{params[:id_utente]}").limit(1).update_all("ban = 1, motivo_ban = '#{params[:motivo]}. Admin: #{current_user.nome}' ")
        Announcement.where("id_proprietario_id = ?",params[:id_utente]).limit(1).update_all("etichetta = 2")
        Booking.where("proprietario_id = ?",params[:id_utente]).destroy_all
        Booking.where("prenotato_id = ?",params[:id_utente]).destroy_all
        respond_to do |format|
                format.html { redirect_to listaUtenti_path, notice: "Hai bannato l'utente!" }
                format.json { head :no_content }
        end
    end
    
    def togliBan
        User.where("id = #{params[:id]}").limit(1).update_all("ban = 0, motivo_ban = '' ")
        respond_to do |format|
                format.html { redirect_to listaUtenti_path, notice: "Hai sbannato l'utente!" }
                format.json { head :no_content }
        end
    end
    

#PRIVATEEEEEE
    private 
    def sei_admin #Filtro che controlla se l'utente è admin, se non lo è blocca tutto!
        if(current_user.tipo_utente == 0)
            respond_to do |format|
                format.html { redirect_to root_url, notice: 'Non puoi accedere alle funzioni admin!' }
                format.json { head :no_content }
            end
        end
    end
end