require_relative 'spec_helper'

describe CodaStandard::TransactionList do
  before :each do
    @transaction_list = CodaStandard::TransactionList.new
  end

  describe "initialize some values" do
    it "has an old_balance" do
      expect(@transaction_list.old_balance).to eq(nil)
    end

    it "has an current_bic" do
      expect(@transaction_list.current_bic).to eq(nil)
    end

    it "has an current_account" do
      expect(@transaction_list.current_account).to eq(nil)
    end
  end

  describe "create" do
    it "creates a new transaction and puts it into the array" do
      @transaction_list.create
      expect(@transaction_list.create).to eq @transaction_list.transactions.last
    end
  end
end