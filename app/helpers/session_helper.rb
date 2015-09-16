module SessionHelper
  def log_in(care_provider)
    session[:care_provider_id] = care_provider.id
  end

  def remember(care_provider)
    care_provider.remember
    cookies.permanent.signed[:care_provider_id] = care_provider.id
    cookies.permanent.signed[:remember_token] = care_provider.remember_token
  end

  def forget(care_provider)
    care_provider.forget
    cookies.delete(:care_provider_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:care_provider_id)
    @current_user = nil
  end

  def current_user
    if care_provider_id = session[:care_provider_id]
      @current_user ||= CareProvider.find_by(id: care_provider_id)
    elsif care_provider_id = cookies.signed[:care_provider_id]
      care_provider = CareProvider.find_by(id: care_provider_id)
      if care_provider && care_provider.authenticated?(cookies[:remember_token])
        log_in care_provider
        @current_user = care_provider
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