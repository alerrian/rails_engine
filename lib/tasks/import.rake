namespace :import do
  desc 'Import files to database tables'

  task from_csv: :environment do
    require 'csv'
    
    Transaction.delete_all
    InvoiceItem.delete_all
    Invoice.delete_all
    Item.delete_all
    Merchant.delete_all
    Customer.delete_all

    customers = CSV.read('db/seeds/customers.csv', headers: true)
    invoice_items = CSV.read('db/seeds/invoice_items.csv', headers: true)
    invoices = CSV.read('db/seeds/invoices.csv', headers: true)
    items = CSV.read('db/seeds/items.csv', headers: true)
    merchants = CSV.read('db/seeds/merchants.csv', headers: true)
    transactions = CSV.read('db/seeds/transactions.csv', headers: true)

    customers.each do |line|
      Customer.create(line.to_h)
    end
    puts 'Customers Imported'

    merchants.each do |line|
      Merchant.create(line.to_h)
    end
    puts 'Merchants Imported'

    items.each do |line|
      Item.create(line.to_h)
    end
    puts 'Items Imported'

    invoices.each do |line|
      Invoice.create(line.to_h)
    end
    puts 'Invoices Imported'

    invoice_items.each do |line|
      InvoiceItem.create(line.to_h)
    end
    puts 'Invoice Items Imported'

    transactions.each do |line|
      Transaction.create(line.to_h)
    end
    puts 'Transactions Imported'

    puts 'Import Complete.'
  end
end