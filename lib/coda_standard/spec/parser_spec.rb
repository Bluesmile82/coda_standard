require_relative 'spec_helper'

describe CodaStandard::Parser do

    before :each do
      @file_name = '../../coda.cod'
      @file = File.open( @file_name )
      @parser = CodaStandard::Parser.new
    end

  describe "initialize" do

    it "initializes some class variables" do
      expect(@parser.transactions).to eq []
      expect(@parser.old_balance).to eq nil
      expect(@parser.current_bic).to eq nil
      expect(@parser.current_account).to eq nil
    end
  end

  describe "parse" do
    it "opens the file" do
    end
    it "creates a new line" do
      expect{@parser.parse(@file_name)}.to change {CodaStandard::Line}
    end
    it "returns an array if transactions" do
    end
  end

  describe "create_transaction" do
    it "creates new transactions" do
      expect{@parser.parse(@file_name)}.to change {@parser.transactions}
    end
  end

  describe "set_address" do
  end

end
