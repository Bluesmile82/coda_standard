# Coda-Standard Gem

This gem parses the Coded statement of account (CODA) bank standard.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coda-standard'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coda-standard

## Usage

  $ CodaStandard::Parser.new.parse(filename)

Returns an array of Transaction instances

  $ CodaStandard::Parser.show.parse(filename)

Shows the transactions info in the terminal

## Contributing

1. Fork it ( https://github.com/[my-github-username]/coda-standard/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
=======

TODO:
