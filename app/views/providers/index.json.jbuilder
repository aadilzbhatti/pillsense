json.array!(@care_providers) do |care_provider|
  json.extract! care_provider, :id, :name
  json.url care_provider_url(care_provider, format: :json)
end
