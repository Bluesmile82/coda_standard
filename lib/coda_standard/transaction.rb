module CodaStandard
  class Transaction
    attr_accessor :name, :currency, :bic, :current_bic ,:address, :postcode, :city, :country, :amount, :old_balance, :account, :current_account, :entry_date, :reference_number
  end
end