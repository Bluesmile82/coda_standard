module CodaStandard
  class Parser
    def initialize
      @transactions = []
      @old_balance = ""
    end

    def parse(file_name)
      File.open( file_name ).each do |row|
        line = Line.new(row)
        if line.line =~ /^1/
          @old_balance = line.set_old_balance
        end
        if line.line =~ /^21/
          create_transaction
          @transactions.last.entry_date = line.set_entry_date
          @transactions.last.reference_number = line.set_reference_number
          @transactions.last.amount = line.set_amount
        end
        if line.line =~ /^23/
          @transactions.last.currency = line.set_currency
          @transactions.last.name = line.set_name
          @transactions.last.account = line.set_account
        end
        if line.line =~ /^32/
          address = line.set_address
          @transactions.last.address = address[:address]
          @transactions.last.postcode = address[:postcode]
          @transactions.last.city = address[:city]
          @transactions.last.country = address[:country]
        end
      end
      @transactions.each{|transaction| transaction.old_balance = @old_balance}
      @transactions
    end

    def create_transaction
      @transactions << Transaction.new
    end

    def show(file_name)
      transactions = parse(file_name)
      puts "**--Transactions--**\n\n"
      puts "Old balance: #{transactions.first.old_balance}\n\n"
      transactions.each_with_index do |transaction, index|
       puts "-- Transaction n.#{index + 1} in date #{transaction.entry_date}-- \n\n"
       puts "   RN: #{transaction.reference_number} Account: #{transaction.account}"
       puts "   Amount: #{transaction.amount} #{transaction.currency}"
       puts "   Name: #{transaction.name}"
       puts "   Address: #{transaction.address} #{transaction.postcode} #{transaction.city} #{transaction.country} \n\n"
      end
    end
  end
end