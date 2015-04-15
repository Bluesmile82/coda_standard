module CodaStandard
  class Transaction
    attr_accessor :name, :currency, :bic, :address, :postcode, :city, :country, :amount, :account, :entry_date, :reference_number, :structured_communication
    def match_structured_communication(structured_communication)
      @structured_communication == structured_communication
    end
  end
end