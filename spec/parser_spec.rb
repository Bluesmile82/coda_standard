require_relative 'spec_helper'

describe CodaStandard::Parser do

  before :each do
    filename = 'spec/coda.cod'
    @parser = CodaStandard::Parser.new(filename)
  end

  describe "initialize" do
    it "initializes some class variables" do
      expect(@parser.transactions).to be_a(CodaStandard::TransactionList)
    end
  end

  describe "parse" do
    before :each do
      @parser.parse
    end

    it "returns a Transactions object" do
        expect(@parser.parse).to be_a(CodaStandard::TransactionList)
    end
  end

  describe "set_address" do
    before :each do
      address = {:address=>"5 RUE DU CENTCINQUANTENAIRE", :postcode=>"6750", :city=>"MUSSY-LA-VILLE", :country=>" BELGIQUE"}
      @parser.set_address(address)
    end

    it "sets the address field to the current transaction" do
      expect(@parser.current_transaction.address).to eq("5 RUE DU CENTCINQUANTENAIRE")
    end

    it "sets the postcode field to the current transaction" do
      expect(@parser.current_transaction.postcode).to eq("6750")
    end

    it "sets the city field to the current transaction" do
      expect(@parser.current_transaction.city).to eq("MUSSY-LA-VILLE")
    end

    it "sets the country field to the current transaction" do
      expect(@parser.current_transaction.country).to eq(" BELGIQUE")
    end
  end

 describe "set_account" do
    before :each do
      account = {account_number:"035918134040", account_type:"bban_be_account"}
      @parser.set_account(account)
    end

    it "sets the current_account field to the TransactionList" do
      expect(@parser.transactions.current_account).to eq("035918134040")
    end

    it "sets the account_type field to the TransactionList" do
      expect(@parser.transactions.current_account_type).to eq("bban_be_account")
    end
  end

  describe "show" do
    it "shows the info from the transactions" do
      expect{@parser.show}.to output("**--Transactions--**\n\nAccount: 539007547034 Account type: bban_be_account BIC: GEBABEBB\nOld balance: 57900,000 \n\n-- Transaction n.1 - number 100000834941 - in date 310315-- \n\n   RN: 0001500000103 Account: BE53900754703405 BIC: GKCCBEBB\n   Amount: 500,000 EUR\n   Name: LASTNM PERSON\n   Address: CHAUSSEE DE BIERE 10 1978 SOMECITY  \n\n-- Transaction n.2 - number 100000835749 - in date 310315-- \n\n   RN: 0001500000104 Account: LU539007547034898400 BIC: BILLLULL\n   Amount: 200,000 EUR\n   Name: M.JOHN DOE\n   Address: 5 STREET 3654 CITY  BELGIQUE \n\n").to_stdout
    end
  end

end
