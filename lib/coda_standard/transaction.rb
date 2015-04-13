module CodaStandard
  class Transaction
    attr_accessor :name, :currency, :bic, :address, :postcode, :city, :country, :amount, :account, :entry_date, :reference_number, :transaction_number
  end
end