require_relative 'spec_helper'

describe CodaStandard::Parser do

  before :each do
    @file_name = 'spec/coda.cod'
    @file = File.open( @file_name )
    @parser = CodaStandard::Parser.new
  end

  describe "initialize" do
    it "initializes some class variables" do
      expect(@parser.transactions).to be_a(CodaStandard::TransactionList)
    end
  end

  describe "parse" do
    before :each do
      @parser.parse(@file_name)
    end
    it "returns a Transactions object" do
        expect(@parser.parse(@file_name)).to be_a(CodaStandard::TransactionList)
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
      expect{@parser.show(@file_name)}.to output("**--Transactions--**\n\nAccount: 035918134040 Account type: bban_be_account BIC: GEBABEBB\nOld balance: 57900,000 \n\n-- Transaction n.1 in date 310315-- \n\n   RN: 0001500000103 Account: BE96553242750005 BIC:GKCCBEBB\n   Amount: 500,000 EUR\n   Name: COUREL PASCAL\n   Address: CHAUSSEE DE MALINES 10 1970 WEZEMBEEK-OPPEM  \n\n-- Transaction n.2 in date 310315-- \n\n   RN: 0001500000104 Account: LU290028159406898400 BIC:BILLLULL\n   Amount: 200,000 EUR\n   Name: M.PASCAL GHELEIN\n   Address: 5 RUE DU CENTCINQUANTENAIRE 6750 MUSSY-LA-VILLE  BELGIQUE \n\n-- Transaction n.3 in date 310315-- \n\n   RN: 0001500000105 Account: BE71142066682269 BIC:GEBABEBB\n   Amount: 100,000 EUR\n   Name: DE MOLDER DIRK\n   Address: KERKHOFDREEF 2 0102 3001 LEUVEN  \n\n-- Transaction n.4 in date 310315-- \n\n   RN: 0001500000106 Account: BE84063438141759 BIC:GKCCBEBB\n   Amount: 100,000 EUR\n   Name: SCHOONJANS ROBIN\n   Address: PL SAINT-BARTHELEMY 6/3 4000 LIEGE  \n\n-- Transaction n.5 in date 310315-- \n\n   RN: 0001500000107 Account: BE60310029825970 BIC:BBRUBEBB\n   Amount: 100,000 EUR\n   Name: M ET MME ROLAND NOBELS\n   Address: PADDESCHOOTDREEF 132 9100 SINT-NIKLAAS  \n\n").to_stdout
    end
  end
end
