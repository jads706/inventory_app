class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      #log_in @user
      flash[:success] = "Created a new user"
      redirect_to "/create_user"
    # else
    #   render 'new'
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
