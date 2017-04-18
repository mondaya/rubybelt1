class User < ActiveRecord::Base
  belongs_to :account, polymorphic: true  
  has_many :credits, :foreign_key => "lender_id", :class_name => "Credit"
  has_many :borrowers, :through => :credits  
  has_many :donations, :foreign_key => "borrower_id", :class_name => "Credit"
  has_many :lenders, :through => :credits  
  has_secure_password  
  

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
 
  validates :first_name, :last_name, presence: true, length: { minimum:2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  before_save :downcase_email

   private
    def downcase_email
      self.email.downcase!
    end
  
  public
  def list_of_people_in_need
      return Borrower.where("amount_raised < amount")              
  end

   def list_of_people_you_lent_money lender_id

        @lender = User.find(lender_id)
        Credit.where(lender_id:lender_id).group(:borrower_id).sum(:amount)      
                 
  end

  def list_of_donors borrower_id

        @borrower = User.find(borrower_id)
        Credit.where(borrower_id:borrower_id).group(:lender_id).sum(:amount)      
                 
  end

end
