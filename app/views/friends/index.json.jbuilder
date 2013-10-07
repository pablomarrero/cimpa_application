json.array!(@friends) do |friend|
  json.extract! friend, :person_id, :person_id
  json.url friend_url(friend, format: :json)
end
