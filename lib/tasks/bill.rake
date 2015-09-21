desc "bills past due accounts with a balance"
task :bill => :environment do
  puts "Preparing to bill (#{Enrollments.billable.count}) accounts"
  puts "Billed (#{Enrollments.charge_billable_accounts.count}) accounts"
end
