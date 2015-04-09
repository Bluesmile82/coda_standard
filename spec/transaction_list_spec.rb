require_relative 'spec_helper'

describe CodaStandard::TransactionList do
  before :each do
    @transaction_list = CodaStandard::TransactionList.new
  end

  describe "initialize some values" do
    it "has an transactions array" do
      expect(@transaction_list.transactions).to eq([])
    end
  end

  describe "create" do
    it "creates a new transaction and puts it into the array" do
      @transaction_list.create
      expect(@transaction_list.create).to eq @transaction_list.transactions.last
    end
  end
end