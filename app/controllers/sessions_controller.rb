class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user.authenticate(params[:session][:password]) && @user
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        flash[:warning] = t('sessions.create.warning')
        redirect_to root_url
      end
    else
      flash.now[:danger] = t('sessions.create.danger')
      render 'new'
    end
  end


  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
