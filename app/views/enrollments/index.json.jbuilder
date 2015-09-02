json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id, :name, :weeks, :financed
  json.url enrollment_url(enrollment, format: :json)
end
