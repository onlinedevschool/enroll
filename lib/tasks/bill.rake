desc "bills past due accounts with a balance"
task :bill => :environment do
  puts "Preparing to bill (#{Enrollment.billable.count}) accounts"
  return if Enrollment.billable.count == 0
  puts "Billed (#{Enrollment.charge_billable_accounts.count}) accounts"
end
