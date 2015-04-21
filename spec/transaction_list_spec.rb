require_relative 'spec_helper'

describe CodaStandard::TransactionList do
  let(:transaction_list) { CodaStandard::TransactionList.new }

  describe "initialize some values" do
    it "has an transactions array" do
      expect(transaction_list.transactions).to eq([])
    end
  end

  describe "create" do
    it "creates a new transaction and puts it into the current transaction list" do
      transaction_list.create_transaction
      expect(transaction_list.create_transaction).to eq transaction_list.transactions.last
    end
  end
end
