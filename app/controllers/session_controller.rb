class SessionController < ApplicationController
  def new
  end

  def create
    care_provider = CareProvider.find_by(email: params[:session][:email].downcase)
    if care_provider && care_provider.authenticate(params[:session][:password])
      log_in care_provider
      params[:session][:remember_me] == '1' ? remember(care_provider) : forget(care_provider)
      redirect_back_or care_provider
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
