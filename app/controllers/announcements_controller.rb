class AnnouncementsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  Numero_risultati_per_pagina = 20
  
  # GET /announcements
  # GET /announcements.json
  def index
    #Solo gli annunci del proprietario e aperti vengono visualizzati.
    @announcements = current_user.oggetti_del_proprietario.paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
    render layout: "per_annunci"
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
    @announcement = Announcement.find(params[:id])
    Announcement.where("id = ?",@announcement.id).limit(1).update_all("visite = #{@announcement.visite+1}")
    render layout: "per_annunci"
  end
  
  def segnala_annuncio
    @announcement = Announcement.find(params[:id])
    Announcement.where("id = ?",@announcement.id).limit(1).update_all("segnalato = 1")
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Annuncio segnalato!' }
      format.json { head :no_content }
    end
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new
    render layout: "per_annunci"
  end

  # GET /announcements/1/edit
  def edit
    #Solo i proprietario degli annunci possono, modificare l'annuncio.
    if(current_user.id == @announcement.id_proprietario_id)
      render layout: "per_annunci"
    else
      redirect_to root_path
    end
  end

  # POST /announcements
  # POST /announcements.json
  def create
    @user = current_user
    @announcement = Announcement.new(params[:announcement].permit(:titolo, :descrizione, :categoria, :foto, :etichetta, :segnalato, :visite, :id_proprietario_id, :luogo))
    @announcement.id_proprietario_id = @user.id
    uploaded_io = params[:announcement][:foto]
    if uploaded_io != nil
      puts "====================================================="
      Rails.logger.debug "#{@announcement.inspect}"
      puts "====================================================="
      estensione = uploaded_io.original_filename.split('.')[-1]
      File.open(Rails.root.join('app','assets','images','foto_annunci', "annuncio#{Announcement.last.id+1}.#{estensione}"), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      @announcement.foto = "foto_annunci/annuncio#{Announcement.last.id+1}.#{estensione}"
    end
    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement}
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    uploaded_io = params[:announcement][:foto]
        if uploaded_io != nil
            #Rails.logger.debug "#{params[:announcement].inspect}"
            if @announcement.foto != "" and @announcement.foto != nil
              file_veccchio = @announcement.foto.split('/')[-1]
              if File.exist?(Rails.root.join('app','assets','images','foto_annunci', "#{file_veccchio}"))
                File.delete(Rails.root.join('app','assets','images','foto_annunci', "#{file_veccchio}"))
              end
            end
            estensione = uploaded_io.original_filename.split('.')[-1]
            File.open(Rails.root.join('app','assets','images','foto_annunci', "annuncio#{@announcement.id}.#{estensione}"), 'wb') do |file|
                file.write(uploaded_io.read)
            end
            params[:announcement][:foto] = "foto_annunci/annuncio#{@announcement.id}.#{estensione}"
            #Rails.logger.debug "#{params[:announcement].inspect}"
        end
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @announcement, notice: 'Annuncio aggiornato!' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    #Se l'annuncio è prenotato, elimino anche la sua annessa prenotazione.
    if(@announcement.prendi_booking != nil) 
      @booking = @announcement.prendi_booking
      @booking.destroy
    end
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Annuncio cancellato!' }
      format.json { head :no_content }
    end
  end
  
  def storico_oggetti_regalati
      @announcements=(current_user.storico_oggetti_regalati).paginate(page: params[:page],per_page: Numero_risultati_per_pagina)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:titolo, :descrizione, :categoria, :foto, :etichetta, :segnalato, :visite, :id_proprietario, :luogo)
    end
end