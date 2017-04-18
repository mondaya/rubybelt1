class CreditController < ApplicationController
  def create
    @borrower_id = User.find(params[:BorrowerId].to_i).id

    

    @credit  =  Credit.new(lender_id:current_user.id, borrower_id:@borrower_id,  amount:params[:AmountLent])
     
    if @credit.invalid?
      flash[:errors] = @credit.errors.full_messages
      return redirect_to  :back       
    end 
    @lender = User.find(current_user.id)
    if params[:AmountLent].to_i > (@lender.account.amount - @lender.account.amount_lent)
         errors = ["Amount is insfficient"]
        flash[:errors] = errors
        return redirect_to  :back 
    end
    @credit.save
    
    @credit.recalculate_amount_balances  current_user.id , @borrower_id
    
    return redirect_to  :back 
    
  end
  
     
end
