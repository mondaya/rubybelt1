class Lender < ActiveRecord::Base
    has_many :users, as: :account
    belongs_to :user

    validates :amount,  presence: true, numericality: {greater_than: 0}
    
    def amount_lent_to_user id
    end

   before_create do
    self.amount_lent = 0;
  end
end
