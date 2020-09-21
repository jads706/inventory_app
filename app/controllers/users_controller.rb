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
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :admin)
    end
end
