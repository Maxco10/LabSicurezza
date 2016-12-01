class Feedback < ActiveRecord::Base
  belongs_to :user
  validates :voto, :presence => true
  validates :proprietario_id, :presence => true
  
end
