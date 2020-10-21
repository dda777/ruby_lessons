class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  include SessionsHelper

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
    { locale: I18n.locale }
  end
end
