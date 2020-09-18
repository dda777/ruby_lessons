module SessionsHelper
  # Осуществляет вход данного пользователя.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Запоминает пользователя в постоянном сеансе.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Возвращает true, если данный пользователь является текущим.
  def current_user?(user)
    user == current_user
  end

  # Возвращает пользователя, соответствующего токену в cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Возвращает true, если пользователь зарегистрирован, иначе возвращает false.
  def logged_in?
    !current_user.nil?
  end

  # Закрывает постоянный сеанс.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Осуществляет выход текущего пользователя.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Перенаправляет по сохраненному адресу или на страницу по умолчанию
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Запоминает URL.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
