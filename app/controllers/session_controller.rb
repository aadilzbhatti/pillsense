class SessionController < ApplicationController
  def new
  end

  def create
    provider = Provider.find_by(email: params[:session][:email].downcase)
    if provider && provider.authenticate(params[:session][:password])
      log_in provider
      params[:session][:remember_me] == '1' ? remember(provider) : forget(provider)
      redirect_back_or provider
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
