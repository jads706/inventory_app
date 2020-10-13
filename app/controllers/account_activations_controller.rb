class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if !user.activated? 
            user.update_attribute(:activated, true)
            user.update_attribute(:activated_at, Time.zone.now)
            #log_in user
            flash[:success] = "Account activated! An Email has been sent to notify user"
            #UserMailer.account_activation(user).deliver_now
            redirect_to '/verify_user'
        else
            flash[:danger] = "Invalid activation link"
            redirect_to root_url
        end
    end

end
