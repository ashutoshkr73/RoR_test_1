class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    respond_to do |format|      
      if user && user.authenticate(params[:session][:password])
        if user.activated?
          log_in user          # calling log_in method that is present in helper file 
          params[:session][:remember_me] == '1' ? remember(user)  : forget(user )
          format.html { redirect_to user_url(user) }
        else
          message = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:warning] = message
          redirect_to root_path
        end  
      else
        flash.now[:danger] = 'Invalid email/password combination' 
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end  

  
  def destroy
    log_out  if logged_in?
    respond_to do |format|          
      flash[:success] = 'User is logged Out'
      format.html { redirect_to root_path }
    end  
  end 

end
