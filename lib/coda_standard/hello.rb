module CodaStandard
  class Parse
    def self.parse(file_name)
      regex_name = /^23\S+\s+([\D\s]+)\d/
      transactions = []
      File.open( file_name ).each do |line|
        if line =~ /^21/
          transaction = Transaction.new
          transactions << transaction
        end
        name = line.scan(regex_name).join.strip
        if line =~ /^23/
          transactions.last.name = name if name != ""
        end
      end

      transactions
    end
  end
  class Transaction
    attr_accessor :name
  end
end