json.array!(@discussions) do |discussion|
  json.extract! discussion, :id, :title, :body, :user_id
  json.url discussion_url(discussion, format: :json)
end
