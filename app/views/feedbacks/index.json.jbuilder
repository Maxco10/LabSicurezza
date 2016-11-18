json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :voto, :proprietario_id
  json.url feedback_url(feedback, format: :json)
end
