class Credit < ActiveRecord::Base
  belongs_to :lender, :foreign_key => "lender_id", :class_name => "User"
  belongs_to :borrower, :foreign_key => "borrower_id", :class_name => "User"

  validates :amount,  presence: true, numericality: {greater_than: 0}

  public
  def recalculate_amount_balances lender_id, borrower_id
        @lender = User.find(lender_id)
        @lender.account.amount_lent = Credit.where(lender_id:lender_id).sum(:amount)
        puts '@lender.account.amount_lent ' , @lender.account.amount_lent.to_s
        @lender.account.save();
        @lender.save()


        @borrower= User.find(borrower_id)
        @borrower.account.amount_raised = Credit.where(borrower_id:borrower_id).sum(:amount)
        puts '@borrower.account.amount_raised' , @borrower.account.amount_raised.to_s
        @borrower.account.save();
        @borrower.save()
  end 


 
end
