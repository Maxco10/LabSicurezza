json.array!(@messages) do |message|
  json.extract! message, :id, :titolo, :testo, :mittente_id, :destinatario_id
  json.url message_url(message, format: :json)
end
