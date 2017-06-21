class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t ".login_success"
      redirect_to user
    else
      flash.now[:danger] = t ".failed_login"
      redirect_to :back
    end
  end

  def destroy
    log_out
    flash[:info] = t ".logout_success"
    redirect_to root_url
  end
end
