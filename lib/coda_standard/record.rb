module CodaStandard
  class Record
    FIELDS = {
      current_bic: /^0.{59}(.{11})/,
      current_account: /^1(.{41})/,
      name: /^23.{45}(.{35})/,
      currency: /^23.{42}(.{3})/,
      entry_date: /^21.{113}(\d{6})/,
      reference_number: /^21.{8}(.{21})/,
      address: /^32.{8}(.{105})/,
      account: /^23\d{8}(\w+)\D/,
      bic: /^22.{96}(.{11})/,
      amount: /^21.{29}(\d{16})/,
      old_balance: /^1.{41}(\d)(\d{15})/,
      sep_address: /(^.+)(\d{4})\s(\S+)(\s\S+)?$/,
      sep_account: /(^.)(.{3})(.+)/,
      bban_be_account: /(^.{12})/,
      bban_foreign_account: /(^.{34})/,
      iban_be_account: /(^.{31})/,
      iban_foreign_account: /(^.{34})/,
      structured_communication: /^21.{60}(.{15})/,
      clean_structured: /.{3}(.{12})/,
      currencies: /(^.+)(AED|AFN|ALL|AMD|ANG|AOA|ARS|AUD|AWG|AZN|BAM|BBD|BDT|BGN|BHD|BIF|BMD|BND|BOB|BOV|BRL|BSD|BTN|BWP|BYR|BZD|CAD|CDF|CHE|CHF|CHW|CLF|CLP|CNY|COP|COU|CRC|CUC|CUP|CVE|CZK|DJF|DKK|DOP|DZD|EGP|ERN|ETB|EUR|FJD|FKP|GBP|GEL|GHS|GIP|GMD|GNF|GTQ|GYD|HKD|HNL|HRK|HTG|HUF|IDR|ILS|INR|IQD|IRR|ISK|JMD|JOD|JPY|KES|KGS|KHR|KMF|KPW|KRW|KWD|KYD|KZT|LAK|LBP|LKR|LRD|LSL|LTL|LVL|LYD|MAD|MDL|MGA|MKD|MMK|MNT|MOP|MRO|MUR|MVR|MWK|MXN|MXV|MYR|MZN|NAD|NGN|NIO|NOK|NPR|NZD|OMR|PAB|PEN|PGK|PHP|PKR|PLN|PYG|QAR|RON|RSD|RUB|RWF|SAR|SBD|SCR|SDG|SEK|SGD|SHP|SLL|SOS|SRD|SSP|STD|SVC|SYP|SZL|THB|TJS|TMT|TND|TOP|TRY|TTD|TWD|TZS|UAH|UGX|USD|USN|USS|UYI|UYU|UZS|VEF|VND|VUV|WST|XAF|XAG|XAU|XBA|XBB|XBC|XBD|XCD|XDR|XFU|XOF|XPD|XPF|XPT|XSU|XTS|XUA|XXX|YER|ZAR|ZMW|ZWL)/
    }

    CLEAN_ZEROS_REGEX = /0*([^0]\d+)(\d{3})/

    def initialize(line)
      @line = line
    end

    def header?
      @line.start_with? "0"
    end

    def data_old_balance?
      @line.start_with? "1"
    end

    def data_movement1?
      @line.start_with? "21"
    end

    def data_movement2?
      @line.start_with? "22"
    end

    def data_movement3?
      @line.start_with? "23"
    end

    def data_information2?
      @line.start_with? "32"
    end

    def current_bic
      extract(:current_bic)
    end

    def current_account
      extract(:current_account)
    end

    def old_balance
      extract(:old_balance)
    end

    def entry_date
      extract(:entry_date)
    end

    def reference_number
      extract(:reference_number)
    end

    def amount
      extract(:amount)
    end

    def bic
      extract(:bic)
    end

    def currency
      extract(:currency)
    end

    def name
      extract(:name)
    end

    def account
      extract(:account)
    end

    def address
      extract(:address)
    end

    def structured_communication
      extract(:structured_communication)
    end

    private

    def extract(field)
      result = @line.scan(FIELDS[field]).join.strip
      case field
        when :address
          result = separate_address(result)
        when :current_account
          result = clean_account(result)
        when :old_balance, :amount
          result = clean_zeros(result)
        when :structured_communication
          result = check_structured(result)
      end
      result
    end

    def separate_address(address)
      address_fields = address.scan(FIELDS[:sep_address])[0]
      {address: address_fields[0].strip, postcode: address_fields[1], city: address_fields[2], country: address_fields[3]}
    end

    def clean_account(account)
      account_type = account.scan(FIELDS[:sep_account])[0][0]
      raw_account = account.scan(FIELDS[:sep_account])[0][2]
      case account_type
        when "0" then account_type = "bban_be_account"
        when "1" then account_type = "bban_foreign_account"
        when "2" then account_type = "iban_be_account"
        when "3" then account_type = "iban_foreign_account"
      end
      account_number = raw_account.scan(FIELDS[account_type.to_sym]).join
      {account_type: account_type, account_number: account_number}
    end

    def clean_zeros(amount)
      amount[0] == "0" ? amount_sign = "" : amount_sign = "-"
      amount_integral = amount.scan(CLEAN_ZEROS_REGEX)[0][0]
      amount_decimals = amount.scan(CLEAN_ZEROS_REGEX)[0][1]
      separator = ","
      amount_sign + amount_integral + separator + amount_decimals
    end

    def check_structured(number)
      if number[0] == "1"
        number.scan(FIELDS[:clean_structured]).join
      else
        "not structured"
      end
    end
  end
end
