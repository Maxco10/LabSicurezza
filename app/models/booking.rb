class Booking < ActiveRecord::Base
  belongs_to :annuncio
  belongs_to :proprietario
  belongs_to :prenotato
end
