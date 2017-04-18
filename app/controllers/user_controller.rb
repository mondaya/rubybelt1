class UserController < ApplicationController
   skip_before_action :require_login, only: [:new, :create]

   #before_action :require_user_auth, except: [:new, :create]

  def show

      if current_user.id === params[:id].to_i
        @user = User.includes(:donations)
                    .includes(:borrowers)
                    .includes(:lenders)
                    .includes(:credits)
                    .find(current_user.id)
        return redirect_to lender_path(@user) if @user.account_type == "Lender"
        return redirect_to borrower_path(@user) if @user.account_type == "Borrower"
      end
      return redirect_to  login_path
  end

  def new
      
  end

  def lender
     
      if current_user.id === params[:id].to_i
        @user = User.find(current_user.id)
        return render
      end
      return redirect_to  login_path

  end 

  def borrower
     
      if current_user.id === params[:id].to_i
        @user = User.find(current_user.id)
        return render
      end
      return redirect_to  login_path

  end 

  def create
    @account_type  = nil
    

    @user = User.new(first_name:params[:FirstName], 
        last_name:params[:LastName],email:params[:Email], 
        password:params[:Password], 
        password_confirmation:params[:Password_Confirmation]) 

    if @user.invalid?
      flash[:errors] = @user.errors.full_messages
      return redirect_to action: "new"
    end

    if params[:UserType] == "borrower"
        @account_type = Borrower.create(amount:params[:Amount], description:params[:Description], reason:params[:Reason], user:@user)
      
      
        if @account_type.valid?
          @user.save
          @user.account = @account_type
          @user.save
          return redirect_to login_path
        end   
    end 

    if params[:UserType] == "lender" 
        @account_type = Lender.create(amount:params[:Amount], user:@user)        
        if @account_type.valid?
          @user.save
          @user.account = @account_type
          @user.save
          return redirect_to login_path   
        end         
    end 

    flash[:errors] = @account_type.nil? ?  ["Unknow account type"] : @account_type.errors.full_messages       
    return redirect_to :back 
   
   


  end

  def edit
     
  end 

  def update
         
    
      @user = User.find(current_user.id)
      @user.name = params[:Name]
      @user.email = params[:Email]

      if @user.save 
        return redirect_to user_path(current_user)
      else
        flash[:errors] = @user.errors.full_messages
        return redirect_to  :back
      end
     
      flash[:errors] = ["Invalid User"]
      session[:user_id] = nil
      return redirect_to action: "new"
  end

  def destroy  

      @user = User.find(current_user.id)   
      @user.delete     
      session[:user_id] = nil
      return redirect_to action: "new"
  end

  private 
  def require_user_auth 
        redirect_to "/users/#{params[:id]}"  unless current_user.id  == params[:id].to_i 
  end 

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
