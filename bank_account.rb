class BankAccount
  attr_accessor :name, :deposit_amount, :withdraw_amount, :transaction_number, :transactions
  attr_reader :balance

  @@min_balance = 200
  @@overdraft_fee = 25

  def initialize(balance,name)
    if balance >= @@min_balance
      @balance = balance
    else
      raise ArgumentError
    end
    @name= name
    @transactions = []
  end

  def self.minimum_balance=(min_balance)
    @@min_balance= min_balance
  end
  
  def self.minimum_balance
   @@min_balance
  end

  def deposit(deposit_amount)
    @balance += deposit_amount
  @transactions << "You have deposited $#{deposit_amount} to your account."
  end

  def withdraw(withdraw_amount)
    @balance -= withdraw_amount
    @transactions << "You have withdrawn $#{withdraw_amount} from our account."
  end

  def transfer(transfer_amount, account_to)
    self.withdraw(transfer_amount)
    account_to.deposit(transfer_amount)
    @transactions << "$#{transfer_amount} was transferred to #{account_to}"
  end

  def overdraft
    if @balance < 0
      @balance -= @@overdraft_fee
    else
      @balance
    end
  end

 def self.overdraft_fee=(overdraft_fee)
   @@overdraft_fee = overdraft_fee
 end
end
