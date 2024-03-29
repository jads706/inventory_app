class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_url
    end
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          redirect_to user
        else
          flash[:warning] = "Account has not been activated"
          redirect_to root_url
        end
      else
        #flash[:danger] = 'Invalid email/password combination' # Not quite right!
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
  end
  def destroy
    log_out
    redirect_to root_url
  end

end
