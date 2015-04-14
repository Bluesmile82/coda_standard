module CodaStandard
  class Parser
    attr_reader :transactions, :old_balance, :current_bic, :current_account, :current_transaction

    def initialize(filename)
      @filename            = filename
      @transactions        = TransactionList.new
      @current_transaction = Transaction.new
    end

    def parse
      File.open(@filename).each do |line|
        record = Record.new(line)
        case
          when line =~ /^0/
            @transactions.current_bic = record.current_bic
          when line =~ /^1/
            set_account(record.current_account)
            @transactions.old_balance = record.old_balance
          when line =~ /^21/
            @current_transaction = @transactions.create
            @current_transaction.entry_date         = record.entry_date
            @current_transaction.reference_number   = record.reference_number
            @current_transaction.amount             = record.amount
            @current_transaction.transaction_number = record.transaction_number
          when line =~ /^22/
            @current_transaction.bic = record.bic
          when line =~ /^23/
            @current_transaction.currency = record.currency
            @current_transaction.name     = record.name
            @current_transaction.account  = record.account
          when line =~ /^32/
            set_address(record.address)
        end
      end
      @transactions
    end

    def set_address(address)
      @current_transaction.address  = address[:address]
      @current_transaction.postcode = address[:postcode]
      @current_transaction.city     = address[:city]
      @current_transaction.country  = address[:country]
    end

    def set_account(account)
      @transactions.current_account      = account[:account_number]
      @transactions.current_account_type = account[:account_type]
    end

    def show
      parse
      puts "**--Transactions--**\n\n"
      puts "Account: #{@transactions.current_account} Account type: #{@transactions.current_account_type} BIC: #{@transactions.current_bic}"
      puts "Old balance: #{@transactions.old_balance} \n\n"
      @transactions.each_with_index do |transaction, index|
        puts "-- Transaction n.#{index + 1} - number #{transaction.transaction_number} - in date #{transaction.entry_date}-- \n\n"
        puts "   RN: #{transaction.reference_number} Account: #{transaction.account} BIC:#{transaction.bic}"
        puts "   Amount: #{transaction.amount} #{transaction.currency}"
        puts "   Name: #{transaction.name}"
        puts "   Address: #{transaction.address} #{transaction.postcode} #{transaction.city} #{transaction.country} \n\n"
      end
    end
  end
end
