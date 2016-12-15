class FeedbacksController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  before_action :set_feedback, only: [:show]
  
  # GET /feedbacks
  # GET /feedbacks.json
  #Profilo utente
  def index
    @user=params[:utente]
    @feedbacks = Feedback.where(proprietario_id: @user)
    #Calcolo della media, sommo tutti i voti dell'utente e li moltiplico per 20 in quanto il nostro range è da 1-5
    @media = 0.0
    @feedbacks.each do | feed |
    @media += feed.voto
    end
    @media = (@media/@feedbacks.count)*20
    
  end

  # GET /feedbacks/new
  def new
    
    @feedback = Feedback.new
    render layout: 'application'
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    Rails.logger.debug "========================================================="
    Rails.logger.debug "#{params}"
    Rails.logger.debug "========================================================="
    @feedback = Feedback.new(feedback_params)
    Announcement.where("id = ?",params[:feedback][:annuncio_id]).limit(1).update_all("etichetta = 2") # => 1
    Booking.where("id = ?",params[:feedback][:booking_id]).limit(1).destroy_all
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to "/feedbacks?utente=#{params[:feedback][:proprietario_id]}", notice: 'Il feedback è stato lasciato correttamente!' }
        format.json { render :index, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:voto, :proprietario_id)
    end
end
