json.array!(@announcements) do |announcement|
  json.extract! announcement, :id, :titolo, :descrizione, :categoria, :foto, :etichetta, :segnalato, :visite
  json.url announcement_url(announcement, format: :json)
end
