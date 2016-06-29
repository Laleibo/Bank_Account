require './bank_account'

describe BankAccount do
  it "is created with an opening balance and the name of the client" do
    account1 = BankAccount.new(500, "Sarah")
    expect(account1).to be_a(BankAccount)
  end

 it "can report it's balance" do
   account1 = BankAccount.new(500,"Sarah")
   expect(account1.balance).to eq(500)
 end

 it "can make deposits" do
   account1 = BankAccount.new(500, "Sarah")
   account1.deposit(500)
   expect(account1.balance).to eq(1000)
 end

 it "can make withdrawals" do
   account1 = BankAccount.new(500,"Sarah")
   account1.withdraw(200)
   expect(account1.balance).to eq(300)
 end

 it "can transfer funds to another bank account" do
  account1 = BankAccount.new(500, "Sarah")
  account2 = BankAccount.new(500, "John")
  account1.transfer(200, account2)
  expect(account1.balance).to eq(300)
  expect(account2.balance).to eq(700)
end

 it "has a minimum opening balance" do
    expect { BankAccount.new(100, "Sarah") }.to raise_error(ArgumentError)
 end

 it "allows the user to change the minimum balance" do
   BankAccount.minimum_balance = 500
   expect {BankAccount.new(100,"Sarah") }.to raise_error(ArgumentError)
   expect {BankAccount.new(500,"Sarah") }.to_not raise_error(ArgumentError)
 end

 it "charges an overdraft fee if balance is below 0" do
   account1 = BankAccount.new(200, "Sarah")
   account1.withdraw(300)
   account1.overdraft
   expect(account1.balance).to eq(-125)
 end

 it "allows bank to change overdraft fee" do
   BankAccount.overdraft_fee=(50)
   account1 = BankAccount.new(200, "Sarah")
   account1.withdraw(300)
   account1.overdraft
   expect(account1.balance).to eq(-150)
  end

 it "shows transaction history of bank account" do
   account1 = BankAccount.new(500, "Sarah")
   account1.deposit(100)
   expect(account1.transactions.first).to match("You have deposited $100 to your account.")
 end

end
