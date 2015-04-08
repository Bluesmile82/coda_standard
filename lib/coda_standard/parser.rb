module CodaStandard
  class Parser
    attr_reader :transactions, :old_balance, :current_bic, :current_account
    def initialize
      @transactions = []
      @old_balance
      @current_bic
      @current_account
    end

    def parse(file_name)
      file = File.open( file_name ).each do |row|
      line = Line.new(row)
      case
        when line.line =~ /^0/
          @current_bic = line.set(:current_bic)
        when line.line =~ /^1/
          @current_account = line.set(:current_account)
          @old_balance = line.set(:old_balance)
        when line.line =~ /^21/
          create_transaction
          @transactions.last.entry_date = line.set(:entry_date)
          @transactions.last.reference_number = line.set(:reference_number)
          @transactions.last.amount = line.set(:amount)
        when line.line =~ /^22/
          @transactions.last.bic = line.set(:bic)
        when line.line =~ /^23/
          @transactions.last.currency = line.set(:currency)
          @transactions.last.name = line.set(:name)
          @transactions.last.account = line.set(:account)
        when line.line =~ /^32/
          address = line.set(:address)
          set_address(address)
        end
      end
      @transactions.each do |transaction|
          transaction.current_account = @current_account
          transaction.old_balance = @old_balance
          transaction.current_bic = @current_bic
        end
      @transactions
    end

    def create_transaction
      @transactions << Transaction.new
    end

    def set_address(address)
      @transactions.last.address = address[:address]
      @transactions.last.postcode = address[:postcode]
      @transactions.last.city = address[:city]
      @transactions.last.country = address[:country]
    end

    def show(file_name)
      transactions = parse(file_name)
      puts "**--Transactions--**\n\n"
      puts "Account: #{transactions.first.current_account} BIC: #{transactions.first.current_bic}"
      puts "Old balance: #{transactions.first.old_balance} \n\n"
      transactions.each_with_index do |transaction, index|
        puts "-- Transaction n.#{index + 1} in date #{transaction.entry_date}-- \n\n"
        puts "   RN: #{transaction.reference_number} Account: #{transaction.account} BIC:#{transaction.bic}"
        puts "   Amount: #{transaction.amount} #{transaction.currency}"
        puts "   Name: #{transaction.name}"
        puts "   Address: #{transaction.address} #{transaction.postcode} #{transaction.city} #{transaction.country} \n\n"
      end
    end
  end
end