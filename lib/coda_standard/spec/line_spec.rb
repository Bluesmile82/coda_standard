require_relative 'spec_helper'

describe CodaStandard::Line do
  before :each do
    @line0 = CodaStandard::Line.new("0000031031520005                  MMIF SA/EVOCURE           GEBABEBB   00538839354 00000                                       2")

    @line1 = CodaStandard::Line.new("10016035918134040 EUR0BE                  0000000057900000300315MMIF SA/EVOCURE                                              017")

    @line21 = CodaStandard::Line.new("21000100000001500000103        0000000000500000010415001500001101100000834941                                      31031501601 0")

    @line22 = CodaStandard::Line.new("2200010000                                                                                        GKCCBEBB                   1 0")

    @line23 = CodaStandard::Line.new("2300010000BE96553242750005                  EURCOUREL PASCAL                                                                 0 1")

    @line32 = CodaStandard::Line.new("3200010001CHAUSSEE DE MALINES 10             1970 WEZEMBEEK-OPPEM                                                            0 0")
    end
  describe "current_bic" do
    it "extracts the current_bic" do
      expect(@line0.current_bic).to eq("GEBABEBB")
    end
  end
  describe "current_account" do
    it "extracts the current_account" do
      expect(@line1.current_account).to eq("035918134040")
    end
  end
  describe "old_balance" do
    it "extracts the old_balance" do
      expect(@line1.old_balance).to eq("57900,000")
    end
  end
  describe "entry_date" do
    it "extracts the entry_date" do
      expect(@line21.entry_date).to eq("310315")
    end
  end
  describe "reference_number" do
    it "extracts the reference_number" do
      expect(@line21.reference_number).to eq("0001500000103")
    end
  end
  describe "amount" do
    it "extracts the amount" do
      expect(@line21.amount).to eq("500,000")
    end
  end
  describe "bic" do
    it "extracts the bic" do
      expect(@line22.bic).to eq("GKCCBEBB")
    end
  end
  describe "currency" do
    it "extracts the currency" do
      expect(@line23.currency).to eq("EUR")
    end
  end
  describe "name" do
    it "extracts the name" do
      expect(@line23.name).to eq("COUREL PASCAL")
    end
  end
  describe "account" do
    it "extracts the account" do
      expect(@line23.account).to eq("BE96553242750005")
    end
  end
  describe "address" do
    it "extracts the address" do
      expect(@line32.address).to eq({:address=>"CHAUSSEE DE MALINES 10", :postcode=>"1970", :city=>"WEZEMBEEK-OPPEM", :country=>nil})
    end
  end

end