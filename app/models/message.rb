class Message < ActiveRecord::Base
  belongs_to :mittente
  belongs_to :destinatario
end
