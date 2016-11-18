json.array!(@bookings) do |booking|
  json.extract! booking, :id, :annuncio_id, :proprietario_id, :prenotato_id
  json.url booking_url(booking, format: :json)
end
