class Announcement < ActiveRecord::Base
    belongs_to :user
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
	
end
