json.array!(@documents) do |document|
  json.extract! document, :id, :content, :version, :meta_info
  json.url document_url(document, format: :json)
end
