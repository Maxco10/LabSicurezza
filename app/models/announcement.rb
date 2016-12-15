class Announcement < ActiveRecord::Base
    belongs_to :user
    has_one :booking
	validates :titolo, :presence => true
	validates :descrizione, :presence => true
	validates :categoria, :presence => true
	
	geocoded_by :luogo
	after_validation :geocode
	
	def nome_creatore
		User.where("id = ?", id_proprietario_id).take.nome
	end
	
	def id_creatore
		User.where("id = ?", id_proprietario_id).take.id
	end
	
	def prendi_booking
		@booking = Booking.where(annuncio_id: id).take
	end
	
	def prenotato_da
		@join = User.joins("INNER JOIN bookings ON bookings.prenotato_id = users.id ").where("annuncio_id = ?", id).take
		if @join
			@join = @join.nome
		else
			""
		end
	end
end
