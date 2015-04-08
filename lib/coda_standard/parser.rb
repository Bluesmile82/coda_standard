module CodaStandard
  class Parser
    attr_reader :transactions, :old_balance, :current_bic, :current_account, :current_transaction
    def initialize
      @transactions = []
      @old_balance
      @current_bic
      @current_account
      @current_transaction = Transaction.new
    end

    def parse(file_name)
      file = File.open( file_name ).each do |row|
      line = Line.new(row)
      case
        when line.line =~ /^0/
          @current_bic = line.current_bic
        when line.line =~ /^1/
          @current_account = line.current_account
          @old_balance = line.old_balance
        when line.line =~ /^21/
          @current_transaction = create_transaction
          @current_transaction.entry_date = line.entry_date
          @current_transaction.reference_number = line.reference_number
          @current_transaction.amount = line.amount
        when line.line =~ /^22/
          @current_transaction.bic = line.bic
        when line.line =~ /^23/
          @current_transaction.currency = line.currency
          @current_transaction.name = line.name
          @current_transaction.account = line.account
        when line.line =~ /^32/
          address = line.address
          set_address(address)
        end
      end
      @transactions
    end

    def create_transaction
      @transactions << Transaction.new
      @transactions.last
    end

    def set_address(address)
      @current_transaction.address = address[:address]
      @current_transaction.postcode = address[:postcode]
      @current_transaction.city = address[:city]
      @current_transaction.country = address[:country]
    end

    def show(file_name)
      transactions = parse(file_name)
      puts "**--Transactions--**\n\n"
      puts "Account: #{@current_account} BIC: #{@current_bic}"
      puts "Old balance: #{@old_balance} \n\n"
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