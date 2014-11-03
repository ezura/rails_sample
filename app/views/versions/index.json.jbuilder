json.array!(@versions) do |version|
  json.extract! version, :id, :document_id, :content
  json.url version_url(version, format: :json)
end
