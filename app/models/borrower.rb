class Borrower < ActiveRecord::Base
    has_many :users, as: :account
    belongs_to :user

    validates :amount,  presence: true, numericality: {greater_than: 0}
    validates :reason,  presence: true, length: {minimum: 5}
    validates :description, presence: true, length: {minimum: 5}
    def amout_borrowed_from_lender id
        
    end

      before_create do
        self.amount_raised = 0;
    end
end
