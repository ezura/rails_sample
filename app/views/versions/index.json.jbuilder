json.array!(@versions) do |version|
  json.extract! version, :id, :document_id, :content, :commit_id
  json.url version_url(version, format: :json)
end
