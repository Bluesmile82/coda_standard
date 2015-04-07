module CodaStandard
  class Line
    attr_reader :line
    def initialize(line)
      @line = line
      @regexp = {
        name: /^23.{45}(.{35})/,
        currency: /^23.{42}(.{3})/,
        entry_date: /^21.{113}(\d{6})/,
        reference_number: /^21.{8}(.{21})/,
        address: /^32.{8}(.{105})/,
        account: /^23\d{8}(\w+)\D/,
        amount: /^21\d+\s+(\d{16})/,
        old_balance: /^1.{41}(\d)(\d{15})/,
        clean_zeros: /0*([^0]\d+)(\d{3})/,
        sep_address: /(^.+)(\d{4})\s(\S+)(\s\S+)?$/
      }
    end
    def set(field)
      result = @line.scan(@regexp[field]).join.strip
      result = separate_address(result) if field == :address
      result = clean_zeros(result) if field == :amount || field == :old_balance
      result
    end
    def separate_address(address)
      address_fields = address.scan(@regexp[:sep_address])[0]
      {address: address_fields[0].strip, postcode: address_fields[1], city: address_fields[2], country: address_fields[3]}
    end
    def clean_zeros(amount)
      amount[0] == "0" ? amount_sign = "" : amount_sign = "-"
      amount_integral = amount.scan(@regexp[:clean_zeros])[0][0]
      amount_decimals = amount.scan(@regexp[:clean_zeros])[0][1]
      separator = ","
      amount_sign + amount_integral + separator + amount_decimals
    end
  end
end