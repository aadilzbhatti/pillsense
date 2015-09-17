module SessionHelper
  def log_in(provider)
    session[:provider_id] = provider.id
  end

  def remember(provider)
    provider.remember
    cookies.permanent.signed[:provider_id] = provider.id
    cookies.permanent.signed[:remember_token] = provider.remember_token
  end

  def forget(provider)
    provider.forget
    cookies.delete(:provider_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:provider_id)
    @current_user = nil
  end

  def current_user
    if provider_id = session[:provider_id]
      @current_user ||= Provider.find_by(id: provider_id)
    elsif provider_id = cookies.signed[:provider_id]
      provider = Provider.find_by(id: provider_id)
      if provider && provider.authenticated?(cookies[:remember_token])
        log_in provider
        @current_user = provider
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end