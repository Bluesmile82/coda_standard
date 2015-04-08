module CodaStandard
  class Line
    attr_reader :line
    def initialize(line)
      @line = line
      @regexp = {
        current_bic: /^0.{59}(.{11})/,
        current_account: /^1.{4}(.{37})/,
        name: /^23.{45}(.{35})/,
        currency: /^23.{42}(.{3})/,
        entry_date: /^21.{113}(\d{6})/,
        reference_number: /^21.{8}(.{21})/,
        address: /^32.{8}(.{105})/,
        account: /^23\d{8}(\w+)\D/,
        bic: /^22.{96}(.{11})/,
        amount: /^21\d+\s+(\d{16})/,
        old_balance: /^1.{41}(\d)(\d{15})/,
        clean_zeros: /0*([^0]\d+)(\d{3})/,
        sep_address: /(^.+)(\d{4})\s(\S+)(\s\S+)?$/,
        currencies:/(^.+)(AED|AFN|ALL|AMD|ANG|AOA|ARS|AUD|AWG|AZN|BAM|BBD|BDT|BGN|BHD|BIF|BMD|BND|BOB|BOV|BRL|BSD|BTN|BWP|BYR|BZD|CAD|CDF|CHE|CHF|CHW|CLF|CLP|CNY|COP|COU|CRC|CUC|CUP|CVE|CZK|DJF|DKK|DOP|DZD|EGP|ERN|ETB|EUR|FJD|FKP|GBP|GEL|GHS|GIP|GMD|GNF|GTQ|GYD|HKD|HNL|HRK|HTG|HUF|IDR|ILS|INR|IQD|IRR|ISK|JMD|JOD|JPY|KES|KGS|KHR|KMF|KPW|KRW|KWD|KYD|KZT|LAK|LBP|LKR|LRD|LSL|LTL|LVL|LYD|MAD|MDL|MGA|MKD|MMK|MNT|MOP|MRO|MUR|MVR|MWK|MXN|MXV|MYR|MZN|NAD|NGN|NIO|NOK|NPR|NZD|OMR|PAB|PEN|PGK|PHP|PKR|PLN|PYG|QAR|RON|RSD|RUB|RWF|SAR|SBD|SCR|SDG|SEK|SGD|SHP|SLL|SOS|SRD|SSP|STD|SVC|SYP|SZL|THB|TJS|TMT|TND|TOP|TRY|TTD|TWD|TZS|UAH|UGX|USD|USN|USS|UYI|UYU|UZS|VEF|VND|VUV|WST|XAF|XAG|XAU|XBA|XBB|XBC|XBD|XCD|XDR|XFU|XOF|XPD|XPF|XPT|XSU|XTS|XUA|XXX|YER|ZAR|ZMW|ZWL)/
      }
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

    private

    def extract(field)
      result = @line.scan(@regexp[field]).join.strip
      case field
        when :address
          result = separate_address(result)
        when :current_account
          result = clean_account(result)
        when :old_balance, :amount
          result = clean_zeros(result)
      end
      result
    end

    def separate_address(address)
      address_fields = address.scan(@regexp[:sep_address])[0]
      {address: address_fields[0].strip, postcode: address_fields[1], city: address_fields[2], country: address_fields[3]}
    end

    def clean_account(account)
      account.scan(@regexp[:currencies])[0][0].strip
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