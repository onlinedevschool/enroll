json.array!(@payments) do |payment|
  json.extract! enrollment, :id, :enrollment_id, :amount, :token, :created_at
  json.url enrollment_payment_url(payment.enrollment, payment, format: :json)
end
