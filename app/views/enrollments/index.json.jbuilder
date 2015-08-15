json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id, :name, :weeks, :course_id, :financed
  json.url enrollment_url(enrollment, format: :json)
end
