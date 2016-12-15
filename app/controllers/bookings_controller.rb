class BookingsController < ApplicationController
    before_filter :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index #i tuoi annunci richiesti
    @bookings = Booking.where("proprietario_id = ?",current_user).order(created_at: :desc)
    @messages = Message.where("mittente_id = ? and destinatario_id = ? ", -1, current_user.id).update_all("stato = 1")
  end
  
  def richieste_inviate
        @bookings = Booking.where("prenotato_id = ?",current_user).order(created_at: :desc)
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
    
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    Rails.logger.debug "========================================================="
    Rails.logger.debug "#{booking_params}"
    Rails.logger.debug "========================================================="
    @booking = Booking.new(booking_params)
    Announcement.where("id = ?",params[:booking][:annuncio_id]).limit(1).update_all("etichetta = 1") # => 1
    @message = Message.new({"titolo"=>"#{@booking.titolo_annuncio}",
                              "testo"=>"L'utente #{@booking.nome_prenotato} si è prenotato all'annuncio #{@booking.titolo_annuncio}!!",
                              "mittente_id"=>"-1",
                              "destinatario_id"=>"#{@booking.proprietario_id}",
                              "stato"=>"0"})
    respond_to do |format|
      if @booking.save
        @message.save
        format.html { redirect_to richieste_inviate_path, notice: 'Prenotazione avvenuta con successo!' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    Announcement.where("id = ?",@booking.annuncio_id).limit(1).update_all("etichetta = 0") # => 1
    respond_to do |format|
      format.html { redirect_to richieste_inviate_path, notice: 'Prenotazione eliminata con successo!' }
      format.json { head :no_content }
    end
  end
  def chiudi_annuncio
    @booking = Booking.find(params[:id])
    Announcement.where("id = ?",@booking.annuncio_id).limit(1).update_all("etichetta = 2") # => 1
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Transazione annuncio chiusa!' }
      format.json { head :no_content }
    end
  end
   
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:annuncio_id, :proprietario_id, :prenotato_id)
    end
    
end
