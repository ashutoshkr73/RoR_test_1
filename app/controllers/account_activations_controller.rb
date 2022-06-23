class AccountActivationsController < ApplicationController


    def edit 
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:authentication , params[:id])
            user.activate

            log_in ( user)
            flash[:success] = 'Account activated successfully'
            redirect_to  user
        else
            flash[:danger] = 'Invalid Activation link'
            redirect_to root_path
        end    
    end    
end
