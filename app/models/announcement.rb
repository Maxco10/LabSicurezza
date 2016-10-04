class Announcement < ActiveRecord::Base
    belongs_to :user
    geocoded_by :luogo
	after_validation :geocode
	validates :titolo, :presence => true
	validates :descrizione, :presence => true
end
