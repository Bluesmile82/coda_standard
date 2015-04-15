require_relative 'spec_helper'

describe CodaStandard::Record do

  let(:header_record) { CodaStandard::Record.new("0000031031520005                  MMIF SA/BANK              GEBABEBB   00538839354 00000                                       2")}
  let(:old_balance_data_record) {  CodaStandard::Record.new("10016539007547034 EUR0BE                  0000000057900000300315MMIF SA/EVOCURE                                              017")}
  let(:data_movement1_record) {  CodaStandard::Record.new("21000100000001500000103        0000000000500000010415001500001101100000834941                                      31031501601 0")}
  let(:data_movement1b_record) {  CodaStandard::Record.new("21000100000001500000103        0000000000500000010415001500001001100000834941                                      31031501601 0")}
  let(:data_movement2_record) {  CodaStandard::Record.new("2200010000                                                                                        GKCCBEBB                   1 0")}
  let(:data_movement3_record) {  CodaStandard::Record.new("2300010000BE53900754703405                  EURLASTNM PERSON                                                                 0 1")}
  let(:data_information2_record) {  CodaStandard::Record.new("32000200015 STREET                                     3654 CITY BELGIQUE                                                    0 0")}

  describe "data_header" do
    it "returns true if the line starts with a zero" do
      expect(header_record.header?).to be true
    end

    it "returns false if the line does not start with a zero" do
      expect(old_balance_data_record.header?).to be false
    end
  end

  describe "data_old_balance" do
    it "returns true if the line starts with a one" do
      expect(old_balance_data_record.data_old_balance?).to be true
    end

    it "returns false if the line does not start with a one" do
      expect(header_record.data_old_balance?).to be false
    end
  end

  describe "data_movement1" do
    it "returns true if the line starts with a 21" do
      expect(data_movement1_record.data_movement1?).to be true
    end

    it "returns false if the line does not start with 21" do
      expect(header_record.data_movement1?).to be false
    end
  end

  describe "data_movement2" do
    it "returns true if the line starts with a 22" do
      expect(data_movement2_record.data_movement2?).to be true
    end

    it "returns false if the line does not start with 22" do
      expect(header_record.data_movement2?).to be false
    end
  end

  describe "data_movement3" do
    it "returns true if the line starts with a 23" do
      expect(data_movement3_record.data_movement3?).to be true
    end

    it "returns false if the line does not start with 23" do
      expect(header_record.data_movement3?).to be false
    end
  end

  describe "data_information2" do
    it "returns true if the line starts with a 32" do
      expect(data_information2_record.data_information2?).to be true
    end

    it "returns false if the line does not start with 32" do
      expect(header_record.data_information2?).to be false
    end
  end

  describe "current_bic" do
    it "extracts the current_bic" do
      expect(header_record.current_bic).to eq("GEBABEBB")
    end
  end

  describe "current_account" do
    it "extracts the current_account" do
      expect(old_balance_data_record.current_account).to eq({account_number:"539007547034", account_type:"bban_be_account"})
    end
  end

  describe "old_balance" do
    it "extracts the old_balance" do
      expect(old_balance_data_record.old_balance).to eq("57900,000")
    end
  end

  describe "entry_date" do
    it "extracts the entry_date" do
      expect(data_movement1_record.entry_date).to eq("310315")
    end
  end

  describe "reference_number" do
    it "extracts the reference_number" do
      expect(data_movement1_record.reference_number).to eq("0001500000103")
    end
  end

  describe "amount" do
    it "extracts the amount" do
      expect(data_movement1_record.amount).to eq("500,000")
    end
  end

  describe "bic" do
    it "extracts the bic" do
      expect(data_movement2_record.bic).to eq("GKCCBEBB")
    end
  end

  describe "currency" do
    it "extracts the currency" do
      expect(data_movement3_record.currency).to eq("EUR")
    end
  end

  describe "name" do
    it "extracts the name" do
      expect(data_movement3_record.name).to eq("LASTNM PERSON")
    end
  end

  describe "account" do
    it "extracts the account" do
      expect(data_movement3_record.account).to eq("BE53900754703405")
    end
  end

  describe "transaction_number" do
    context "structured_number" do
      it "extracts the number" do
        expect(data_movement1_record.transaction_number).to eq("100000834941")
      end
    end
    context "non-structured_number" do
      it "returns not structured" do
        expect(data_movement1b_record.transaction_number).to eq("not structured")
      end
    end
  end

  describe "address" do
    it "extracts the address" do
      expect(data_information2_record.address).to eq({:address=>"5 STREET", :postcode=>"3654", :city=>"CITY", :country=>" BELGIQUE"})
    end
  end

end
