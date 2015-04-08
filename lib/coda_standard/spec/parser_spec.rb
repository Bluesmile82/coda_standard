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
    before :each do
      @parser.parse(@file_name)
    end

    it "returns an array" do
      expect(@parser.transactions).to be_a(Array)
    end

    it "returns an array of transactions" do
      @parser.transactions.each do |transaction|
        expect(transaction).to be_a(CodaStandard::Transaction)
      end
    end
    it "has an old_balance" do
      expect(@parser.old_balance).not_to eq(nil)
    end
    it "has an current_bic" do
      expect(@parser.current_bic).not_to eq(nil)
    end
     it "has an current_account" do
      expect(@parser.current_account).not_to eq(nil)
    end
  end

  describe "create_transaction" do
    it "creates new transactions" do
      transaction = @parser.create_transaction
      expect(@parser.transactions.last).to be(transaction)
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
  describe "show" do
    it "shows the info from the transactions" do
      expect{@parser.show(@file_name)}.to output("**--Transactions--**\n\nAccount: 035918134040 BIC: GEBABEBB\nOld balance: 57900,000 \n\n-- Transaction n.1 in date 310315-- \n\n   RN: 0001500000103 Account: BE96553242750005 BIC:GKCCBEBB\n   Amount: 500,000 EUR\n   Name: COUREL PASCAL\n   Address: CHAUSSEE DE MALINES 10 1970 WEZEMBEEK-OPPEM  \n\n-- Transaction n.2 in date 310315-- \n\n   RN: 0001500000104 Account: LU290028159406898400 BIC:BILLLULL\n   Amount: 200,000 EUR\n   Name: M.PASCAL GHELEIN\n   Address: 5 RUE DU CENTCINQUANTENAIRE 6750 MUSSY-LA-VILLE  BELGIQUE \n\n-- Transaction n.3 in date 310315-- \n\n   RN: 0001500000105 Account: BE71142066682269 BIC:GEBABEBB\n   Amount: 100,000 EUR\n   Name: DE MOLDER DIRK\n   Address: KERKHOFDREEF 2 0102 3001 LEUVEN  \n\n-- Transaction n.4 in date 310315-- \n\n   RN: 0001500000106 Account: BE84063438141759 BIC:GKCCBEBB\n   Amount: 100,000 EUR\n   Name: SCHOONJANS ROBIN\n   Address: PL SAINT-BARTHELEMY 6/3 4000 LIEGE  \n\n-- Transaction n.5 in date 310315-- \n\n   RN: 0001500000107 Account: BE60310029825970 BIC:BBRUBEBB\n   Amount: 100,000 EUR\n   Name: M ET MME ROLAND NOBELS\n   Address: PADDESCHOOTDREEF 132 9100 SINT-NIKLAAS  \n\n").to_stdout
    end
  end
end
