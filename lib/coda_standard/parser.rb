module CodaStandard
  class Parser
    attr_reader :transactions, :old_balance, :current_bic, :current_account, :current_transaction, :current_transaction_list

    def initialize(filename)
      @filename            = filename
      @transactions        = []
      @current_transaction_list = TransactionList.new
      @current_transaction = Transaction.new
    end

    def parse
      File.open(@filename).each do |line|
        record = Record.new(line)
        case
        when record.header?
          create_transaction_list
          @current_transaction_list.current_bic = record.current_bic
        when record.data_old_balance?
          set_account(record.current_account)
          @current_transaction_list.old_balance = record.old_balance
        when record.data_movement1?
          create_transaction
          extract_data_movement1(record)
        when record.data_movement2?
          extract_data_movement2(record)
        when record.data_movement3?
          extract_data_movement3(record)
        when record.data_information2?
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
     @current_transaction_list.current_account      = account[:account_number]
     @current_transaction_list.current_account_type = account[:account_type]
    end

    def create_transaction
      @current_transaction = @current_transaction_list.create_transaction
    end

    def create_transaction_list
      @current_transaction_list = TransactionList.new
      @transactions << @current_transaction_list
    end

    def extract_data_movement1(record)
      @current_transaction.entry_date         = record.entry_date
      @current_transaction.reference_number   = record.reference_number
      @current_transaction.amount             = record.amount
      @current_transaction.structured_communication = record.structured_communication
    end

    def extract_data_movement2(record)
       @current_transaction.bic = record.bic
    end

    def extract_data_movement3(record)
      @current_transaction.currency = record.currency
      @current_transaction.name     = record.name
      @current_transaction.account  = record.account
    end

    def show
      parse
      @transactions.each_with_index do |transaction, index|
        puts "**--Transaction List #{ index + 1 }--**\n\n"
        puts "Account: #{transaction.current_account} Account type: #{transaction.current_account_type} BIC: #{transaction.current_bic}"
        puts "Old balance: #{transaction.old_balance} \n\n"
        transaction.each_with_index do |transaction, index|
          puts "-- Transaction n.#{index + 1} - number #{transaction.structured_communication} - in date #{transaction.entry_date}-- \n\n"
          puts "   RN: #{transaction.reference_number} Account: #{transaction.account} BIC: #{transaction.bic}"
          puts "   Amount: #{transaction.amount_money}"
          puts "   Name: #{transaction.name}"
          puts "   Address: #{transaction.address} #{transaction.postcode} #{transaction.city} #{transaction.country} \n\n"
        end
      end
    end
  end
end
