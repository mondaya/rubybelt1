class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

   def current_user
     begin
        User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound 
        nil
    end
  end
  helper_method :current_user 

  private
 
  def require_login
    unless current_user
      flash[:error] = ["You must be logged in to access this section"]
      redirect_to login_path # halts request cycle
    end
  end

  before_action :require_login
end
