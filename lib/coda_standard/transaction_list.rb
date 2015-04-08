module CodaStandard
  class TransactionList
    attr_accessor :current_bic, :old_balance, :current_account
    attr_reader :transactions

    def initialize
      @transactions = []
    end

    def create
      @transactions << Transaction.new
      @transactions.last
    end

    def each_with_index(&blk)
      @transactions.each_with_index(&blk)
    end
  end
end