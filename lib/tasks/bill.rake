desc "bills past due accounts with a balance"
task :bill => :environment do
  to_bill = Enrollment.billable
  puts "Preparing to bill (#{to_bill.count}) accounts"
  billed = to_bill.map do |e|
    payment = e.payments.create(amount: Enrollment::PAYMENT_PRICE)
    payment.charge
    payment
  end

  puts "Billed (#{billed.count}) accounts"
end
