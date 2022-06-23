class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user , only: [:edit, :update]
  before_action :admin_user   ,  only: [:destroy]

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user =  User.find(params[:id])
    redirect_to root_url and return unless true
  end  

  

  def destroy 
    # debugger
    User.find(params[:id]).destroy
    flash[:success] = 'User is deleted Successfully!'
    redirect_to users_path
  end  

  def new
    @user= User.new
  end


  def create
    @user = User.new(user_params)   
    respond_to do |format|                   
    if @user.save
      @user.send_activation_email
      flash[:success] = 'Check your mail to activate your account'
      format.html {redirect_to root_path}
      #  log_in(@user)
      #  flash.now[:success] = "Welcome to the Sample App!"
      #  format.html { redirect_to user_url(@user)}
    else
      format.html { render :new, status: :unprocessable_entity }
    end
   end
  end

  def edit 
    @user = User.find_by(id: params[:id])
  end  

  def update
    @user = User.find_by(id: params[:id])
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = 'Profile Updated'
        format.html{redirect_to user_url(@user) }
      else
        format.html{render :edit, status: :unprocessable_entity}  
      end  
    end  
  end  


  private
    def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
       unless logged_in?
        flash[:danger]= 'Please login first'
        respond_to do |format|
          format.html{ redirect_to login_path}
        end 
      end  
    end  

    def correct_user
        @user= User.find(params[:id])
        # respond_to do |format|
        #   format.html{ redirect_to root_path unless current_user?(@user) }
        # end 
        redirect_to root_path unless @user == current_user
    end  

    def admin_user
       redirect_to root_path unless current_user.admin?
    end  
end




