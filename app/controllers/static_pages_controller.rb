class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to current_user
    else
      redirect_to root_url
    end
  end
  
  def help
  end
end
