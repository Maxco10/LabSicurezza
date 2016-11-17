class Announcement < ActiveRecord::Base
    belongs_to :user
	validates :titolo, :presence => true
	validates :descrizione, :presence => true
	
	geocoded_by :luogo
	after_validation :geocode
end
