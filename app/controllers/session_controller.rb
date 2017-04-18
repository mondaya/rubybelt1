class SessionController < ApplicationController
  skip_before_action :require_login, only: [:new, :create] 
    def new
        # render login page
    end
    def create
        # Log User In
        # if authenticate true
            # save user id to session
            # redirect to users profile page
        # if authenticate false
            # add an error message -> flash[:errors] = ["Invalid"]
            # redirect to login page
        @user = User.find_by_email(params[:Email].downcase) if params[:Email]
        if @user.try(:authenticate, params[:Password])
                session[:user_id] =  @user.id
                return redirect_to "/users/#{@user.id}"
        else
            errors = ["Invalid User\n\r"]
            errors.push "Email required\n\r"  if params[:Email].empty?
            errors.push "Password required\n\r"  if params[:Password].empty?
            flash[:errors] = errors
            session[:user_id]  = nil
            return redirect_to :back
        end

    end
    

    def destroy
        # Log User out
        session[:user_id]  = nil
        return redirect_to login_path
    end
end
