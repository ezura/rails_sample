json.array!(@documents) do |document|
  json.extract! document, :id, :contents, :version, :meta, :tmp
  json.url document_url(document, format: :json)
end
