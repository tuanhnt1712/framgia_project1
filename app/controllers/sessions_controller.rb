class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      log_in user
      "1" == params[:session][:remember_me] ? remember(user) : forget(user)
      flash[:success] = t ".login_success"
      redirect_to user
    else
      flash[:danger] = t ".failed_login"
      redirect_to :back
    end
  end

  def destroy
    log_out if logged_in?
    flash[:info] = t ".logout_success"
    redirect_to root_url
  end
end
