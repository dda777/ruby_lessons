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
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end



  # def browser_locale(request)
  #   locales = request.env['HTTP_ACCEPT_LANGUAGE'] || ""
  #   locales.scan(/[a-z]{2}(?=;)/).find do |locale|
  #     I18n.available_locales.include?(locale.to_sym)
  #   end
  # end
end
