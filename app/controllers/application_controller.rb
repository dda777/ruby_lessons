class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  around_action :switch_locale
  include SessionsHelper

  def switch_locale(&action)
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = extract_locale_from_header
    logger.debug "* Locale set to '#{locale}'"
    I18n.with_locale(locale, &action)
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t('common.please_login')
      redirect_to login_url
    end
  end


  def default_url_options
    {locale: I18n.locale}
  end

  def extract_locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

end
