# coda_standard Gem

This gem parses the Coded statement of account (CODA) bank standard.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coda_standard'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coda_standard

## Usage

    $ CodaStandard::Parser.new.parse(filename)

Returns an TransactionList object

    $ CodaStandard::Parser.new.parse(filename).transactions

Returns an array of transactions

    $ CodaStandard::Parser.new.parse(filename).current_bic => "GEBABEBB"

You can get different common data from the TransactionList (current_bic, old_balance, current_account, current_account_type)

    $ CodaStandard::Parser.new.show(filename)

Shows the transactions info in the terminal

The info you can get from each transaction is:
  name, currency, bic, address, postcode, city, country, amount, account, entry_date, reference_number and transaction_number

## Contributing

1. Fork it ( https://github.com/Bluesmile82/coda_standard/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

=======
