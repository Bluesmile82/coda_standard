module CodaStandard
  class Parser

    def initialize
      @transactions = []
      @old_balance = ""
    end

    def parse(file_name)
      File.open( file_name ).each do |line|
        if line =~ /^1/
          set_old_balance(line)
        end
        if line =~ /^21/
          create_transaction
          set_entry_date(line)
          set_amount(line)
          set_reference_number(line)
        end
        if line =~ /^23/
          set_name(line)
          set_account(line)
        end
        if line =~ /^32/
          set_address(line)
        end
      end
      @transactions.each{|transaction| transaction.old_balance = @old_balance}
      @transactions
    end

    def create_transaction
      @transactions << Transaction.new
    end

    def set_name(line)
      regex_name = /^23\S+\s+([\D\s]+)\d/
      regex_currencies = /^(AED|AFN|ALL|AMD|ANG|AOA|ARS|AUD|AWG|AZN|BAM|BBD|BDT|BGN|BHD|BIF|BMD|BND|BOB|BOV|BRL|BSD|BTN|BWP|BYR|BZD|CAD|CDF|CHE|CHF|CHW|CLF|CLP|CNY|COP|COU|CRC|CUC|CUP|CVE|CZK|DJF|DKK|DOP|DZD|EGP|ERN|ETB|EUR|FJD|FKP|GBP|GEL|GHS|GIP|GMD|GNF|GTQ|GYD|HKD|HNL|HRK|HTG|HUF|IDR|ILS|INR|IQD|IRR|ISK|JMD|JOD|JPY|KES|KGS|KHR|KMF|KPW|KRW|KWD|KYD|KZT|LAK|LBP|LKR|LRD|LSL|LTL|LVL|LYD|MAD|MDL|MGA|MKD|MMK|MNT|MOP|MRO|MUR|MVR|MWK|MXN|MXV|MYR|MZN|NAD|NGN|NIO|NOK|NPR|NZD|OMR|PAB|PEN|PGK|PHP|PKR|PLN|PYG|QAR|RON|RSD|RUB|RWF|SAR|SBD|SCR|SDG|SEK|SGD|SHP|SLL|SOS|SRD|SSP|STD|SVC|SYP|SZL|THB|TJS|TMT|TND|TOP|TRY|TTD|TWD|TZS|UAH|UGX|USD|USN|USS|UYI|UYU|UZS|VEF|VND|VUV|WST|XAF|XAG|XAU|XBA|XBB|XBC|XBD|XCD|XDR|XFU|XOF|XPD|XPF|XPT|XSU|XTS|XUA|XXX|YER|ZAR|ZMW|ZWL)/
      name = line.scan(regex_name).join.strip.gsub!(regex_currencies, "")
      @transactions.last.name = name if name != ""
    end
    def set_entry_date(line)
      regex_entry_date = /^21.{113}(\d{6})/
      entry_date = line.scan(regex_entry_date).join.strip
      @transactions.last.entry_date = entry_date if entry_date != ""
    end
    def set_reference_number(line)
      regex_reference_number = /^21.{8}(.{21})/
      reference_number = line.scan(regex_reference_number).join.strip
      @transactions.last.reference_number = reference_number if reference_number != ""
    end
    def set_address(line)
      regex_address = /^32\d{8}(.+)[10]\s[10]$/
      address = line.scan(regex_address).join.strip
      @transactions.last.address = address if address != ""
    end
    def set_account(line)
      regex_account = /^23\d{8}(\w+)\s/
      account = line.scan(regex_account).join.strip
      @transactions.last.account = account if account != ""
    end
    def set_amount(line)
      regex_amount = /^21\d+\s+(\d{16})/
      regex_clean_zeros = /0*([^0]\d+)(\d{3})/
      amount = line.scan(regex_amount).join
      amount[0] == "0" ? amount_sign = "" : amount_sign = "-"
      amount_integral = amount.scan(regex_clean_zeros)[0][0]
      amount_decimals = amount.scan(regex_clean_zeros)[0][1]
      separator = ","
      amount = amount_sign + amount_integral + separator + amount_decimals
      @transactions.last.amount = amount if amount != ""
    end
    def set_old_balance(line)
      regex_amount = /^1.{41}(\d)(\d{15})/
      regex_clean_zeros = /0*([^0]\d+)(\d{3})/
      amount = line.scan(regex_amount).join
      amount[0] == "0" ? amount_sign = "" : amount_sign = "-"
      amount_integral = amount.scan(regex_clean_zeros)[0][0]
      amount_decimals = amount.scan(regex_clean_zeros)[0][1]
      separator = ","
      amount = amount_sign + amount_integral + separator + amount_decimals
      @old_balance = amount if amount != ""
    end
  end
end