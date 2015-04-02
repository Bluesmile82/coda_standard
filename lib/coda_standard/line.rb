module CodaStandard
  class Line
    attr_reader :line
    def initialize(line)
      @line = line
    end
      # regex_currencies = /^(AED|AFN|ALL|AMD|ANG|AOA|ARS|AUD|AWG|AZN|BAM|BBD|BDT|BGN|BHD|BIF|BMD|BND|BOB|BOV|BRL|BSD|BTN|BWP|BYR|BZD|CAD|CDF|CHE|CHF|CHW|CLF|CLP|CNY|COP|COU|CRC|CUC|CUP|CVE|CZK|DJF|DKK|DOP|DZD|EGP|ERN|ETB|EUR|FJD|FKP|GBP|GEL|GHS|GIP|GMD|GNF|GTQ|GYD|HKD|HNL|HRK|HTG|HUF|IDR|ILS|INR|IQD|IRR|ISK|JMD|JOD|JPY|KES|KGS|KHR|KMF|KPW|KRW|KWD|KYD|KZT|LAK|LBP|LKR|LRD|LSL|LTL|LVL|LYD|MAD|MDL|MGA|MKD|MMK|MNT|MOP|MRO|MUR|MVR|MWK|MXN|MXV|MYR|MZN|NAD|NGN|NIO|NOK|NPR|NZD|OMR|PAB|PEN|PGK|PHP|PKR|PLN|PYG|QAR|RON|RSD|RUB|RWF|SAR|SBD|SCR|SDG|SEK|SGD|SHP|SLL|SOS|SRD|SSP|STD|SVC|SYP|SZL|THB|TJS|TMT|TND|TOP|TRY|TTD|TWD|TZS|UAH|UGX|USD|USN|USS|UYI|UYU|UZS|VEF|VND|VUV|WST|XAF|XAG|XAU|XBA|XBB|XBC|XBD|XCD|XDR|XFU|XOF|XPD|XPF|XPT|XSU|XTS|XUA|XXX|YER|ZAR|ZMW|ZWL)/
    def set_name
      regex_name = /^23.{45}(.{35})/
      @line.scan(regex_name).join.strip
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
      regex_clean_zeros = /0*([^0]\d+)(\d{3})/
      amount = @line.scan(regex_amount).join
      amount[0] == "0" ? amount_sign = "" : amount_sign = "-"
      amount_integral = amount.scan(regex_clean_zeros)[0][0]
      amount_decimals = amount.scan(regex_clean_zeros)[0][1]
      separator = ","
      amount_sign + amount_integral + separator + amount_decimals
    end
    def set_old_balance
      regex_amount = /^1.{41}(\d)(\d{15})/
      regex_clean_zeros = /0*([^0]\d+)(\d{3})/
      amount = @line.scan(regex_amount).join
      amount[0] == "0" ? amount_sign = "" : amount_sign = "-"
      amount_integral = amount.scan(regex_clean_zeros)[0][0]
      amount_decimals = amount.scan(regex_clean_zeros)[0][1]
      separator = ","
      amount_sign + amount_integral + separator + amount_decimals
    end
  end
end