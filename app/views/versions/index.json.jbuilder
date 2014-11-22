json.array!(@versions) do |version|
  json.extract! version, :id, :document_id, :version, :contents, :meta
  json.url version_url(version, format: :json)
end
