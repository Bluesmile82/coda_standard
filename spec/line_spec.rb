require_relative 'spec_helper'

describe CodaStandard::Line do
  let(:line0) { CodaStandard::Line.new("0000031031520005                  MMIF SA/BANK              GEBABEBB   00538839354 00000                                       2") }
  let(:line1) { CodaStandard::Line.new("10016539007547034 EUR0BE                  0000000057900000300315MMIF SA/EVOCURE                                              017") }
  let(:line21) { CodaStandard::Line.new("21000100000001500000103        0000000000500000010415001500001101100000834941                                      31031501601 0") }
  let(:line21b) { CodaStandard::Line.new("21000100000001500000103        0000000000500000010415001500001001100000834941                                      31031501601 0") }
  let(:line22) { CodaStandard::Line.new("2200010000                                                                                        GKCCBEBB                   1 0") }
  let(:line23) { CodaStandard::Line.new("2300010000BE53900754703405                  EURLASTNM PERSON                                                                 0 1") }
  let(:line32) { CodaStandard::Line.new("32000200015 STREET                                     3654 CITY BELGIQUE                                                    0 0") }

  describe "current_bic" do
    it "extracts the current_bic" do
      expect(line0.current_bic).to eq("GEBABEBB")
    end
  end

  describe "current_account" do
    it "extracts the current_account" do
      expect(line1.current_account).to eq({account_number:"539007547034", account_type:"bban_be_account"})
    end
  end

  describe "old_balance" do
    it "extracts the old_balance" do
      expect(line1.old_balance).to eq("57900,000")
    end
  end

  describe "entry_date" do
    it "extracts the entry_date" do
      expect(line21.entry_date).to eq("310315")
    end
  end

  describe "reference_number" do
    it "extracts the reference_number" do
      expect(line21.reference_number).to eq("0001500000103")
    end
  end

  describe "amount" do
    it "extracts the amount" do
      expect(line21.amount).to eq("500,000")
    end
  end

  describe "bic" do
    it "extracts the bic" do
      expect(line22.bic).to eq("GKCCBEBB")
    end
  end

  describe "currency" do
    it "extracts the currency" do
      expect(line23.currency).to eq("EUR")
    end
  end

  describe "name" do
    it "extracts the name" do
      expect(line23.name).to eq("LASTNM PERSON")
    end
  end

  describe "account" do
    it "extracts the account" do
      expect(line23.account).to eq("BE53900754703405")
    end
  end

  describe "transaction_number" do
    context "structured_number" do
      it "extracts the number" do
        expect(line21.transaction_number).to eq("100000834941")
      end
    end
    context "non-structured_number" do
      it "returns not structured" do
        expect(line21b.transaction_number).to eq("not structured")
      end
    end
  end

  describe "address" do
    it "extracts the address" do
      expect(line32.address).to eq({:address=>"5 STREET", :postcode=>"3654", :city=>"CITY", :country=>" BELGIQUE"})
    end
  end

end
