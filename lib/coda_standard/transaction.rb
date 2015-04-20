module CodaStandard
  class Transaction
    attr_accessor :name, :currency, :bic, :address, :postcode, :city, :country, :amount, :account, :entry_date, :reference_number, :structured_communication

    def match_structured_communication(structured_communication)
      @structured_communication == structured_communication
    end

    def amount_cents
      (@amount.to_f * 100).to_i
    end

    def amount_money
      "#{ amount_cents.to_s.insert(-3, ',') } #{ @currency }"
    end
  end
end