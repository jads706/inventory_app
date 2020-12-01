class UsersController < ApplicationController
  #Admin restricted pages
  def ensure_admin!
    unless current_user and current_user.admin?
      redirect_to root_url
      flash[:danger] = "You do not have proper authorization"
    end
  end
  def index
    ensure_admin!
  end
  
  def create_user
    ensure_admin!
  end
  def verify_user
    ensure_admin!
  end
  
  #User Pages and also accessible to users
  def ensure_user!
    unless current_user
      redirect_to root_url
      flash[:danger] = "You are not logged in"
    end
  end
  def checkout
    ensure_user!
  end
  
  #Methods
  def show
    @user = User.find(params[:id])
    if current_user.admin?
      redirect_to "/units"
    else
      redirect_to "/checkout"
    end
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    #Checks if admin is creating 
    if logged_in?
      if @user.save
        @user.activated = true
        @user.activated_at = Time.zone.now
        #log_in @user
        flash[:success] = "Created a new user"
        redirect_to "/create_user"
      end
    #Else by default for signup
    else
      if @user.save
        #UserMailer.account_activation(@user).deliver_now
        flash[:info] = "Request for activation has been sent, please wait for email to notify that account has been created."
        redirect_to root_url
      else
        render 'new'
      end
    end
  end
  def destroy
    hasItems = false
    Unit.all.each do |unit|
      if unit.location == User.find(params[:id]).name
        if hasItems == false
          hasItems = true
        end
      end
    end
    if hasItems == false
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to '/users'
    else
      flash[:danger] = "User still has items, cannot be deleted"
      redirect_to '/users'
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
        flash[:success] = "Changed Successfully"
        redirect_to "/users"
    else
        flash[:danger] = "Error Occured"
    end
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :admin)
    end
end
