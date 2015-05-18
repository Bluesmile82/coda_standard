# coda_standard

This gem parses the [Coded statement of account](https://www.febelfin.be/sites/default/files/files/Standard-CODA-22-EN.pdf) (CODA) bank standard used by some  banks and follows version 2.2 of this standard.

> This bank standard specifies the lay-out for the electronic files, by banks to customers, of the account transactions and the information concerning the enclosures in connection with the movement.

The coda_standard gem requires Ruby version ~> 2.0.

## Install

    $ gem install coda_standard

or add the following line to Gemfile:

```
gem 'coda_standard'
```

and run `bundle install` from your shell.

## Usage

```ruby

# a new TransactionList objects array:
CodaStandard::Parser.new(filename).parse

# or an array of Transaction Objects from the first Transaction List:
CodaStandard::Parser.new(filename).parse.first.transactions

# or maybe the BIC of the first TransactionList:
CodaStandard::Parser.new(filename).parse.first.current_bic => 'GEBABEBB'

# or the amount of the first Transaction:
CodaStandard::Parser.new(filename).parse.first.transactions[0].amount

# or print a more readable representation of the file
CodaStandard::Parser.new(filename).show

# you can also find a transaction inside a transaction list object by the structured communication number
CodaStandard::Parser.new(filename).parse.first.find_by_structured_communication('100000001234')
```
The available getters for each TransactionList are: `old_balance`, `current_account`, `current_account_type`, `current_bic`

The available getters for each Transaction are: `name`, `currency`, `bic`, `address`, `postcode`, `city`, `country`, `amount`, `account`, `entry_date` (returns a Date), `reference_number` and `structured_communication`.

You can get the amount in cents: `amount_cents` => 50086

or with the currency: `amount_money` => '500,86 EUR'

## Contributing

1. Fork it ( https://github.com/Bluesmile82/coda_standard/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

coda_standard is Copyright © 2015 Alvaro Leal. It is free software, and may be redistributed under the terms specified in the [LICENSE](LICENSE) file.
