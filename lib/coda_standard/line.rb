module CodaStandard
  class Line
    attr_reader :line
    def initialize(line)
      @line = line
    end
    def set_name
      regex_name = /^23.{45}(.{35})/
      @line.scan(regex_name).join.strip
    end
    def set_currency
      regex_currency = /^23.{42}(.{3})/
      @line.scan(regex_currency).join
    end
    def set_entry_date
      regex_entry_date = /^21.{113}(\d{6})/
      @line.scan(regex_entry_date).join.strip
    end
    def set_reference_number
      regex_reference_number = /^21.{8}(.{21})/
      @line.scan(regex_reference_number).join.strip
    end
    def set_address
      regex_address = /^32.{8}(.{105})/
      regex_separate_address = /(^.+)(\d{4})\s(\S+)(\s\S+)?$/
      address = @line.scan(regex_address).join.strip
      address_fields = address.scan(regex_separate_address)[0]
      {address: address_fields[0].strip, postcode: address_fields[1], city: address_fields[2], country: address_fields[3]}
    end
    def set_account
      regex_account = /^23\d{8}(\w+)\D/
      @line.scan(regex_account).join.strip

    end
    def set_amount
      regex_amount = /^21\d+\s+(\d{16})/
      amount = @line.scan(regex_amount).join
      clean_zeros(amount)
    end
    def set_old_balance
      regex_amount = /^1.{41}(\d)(\d{15})/
      amount = @line.scan(regex_amount).join
      clean_zeros(amount)
    end

    def clean_zeros(amount)
      regex_clean_zeros = /0*([^0]\d+)(\d{3})/
      amount[0] == "0" ? amount_sign = "" : amount_sign = "-"
      amount_integral = amount.scan(regex_clean_zeros)[0][0]
      amount_decimals = amount.scan(regex_clean_zeros)[0][1]
      separator = ","
      amount_sign + amount_integral + separator + amount_decimals
    end
  end
end