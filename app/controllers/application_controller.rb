class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  # before_action :locale_from_ip

  def set_locale
    session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = params[:locale] if params[:locale].present?
  end

  # def locale_from_ip
  #   if session[:locale].nil? && Geocoder.search(request.remote_ip).first.country == "Poland"
  #     session[:locale] = "pl"
  #   elsif session[:locale].nil?
  #     session[:locale] = "en"
  #   end
  # end

  def default_url_option ( options = {})
    session[:locale] = I18n.locale
    {locale: I18n.locale}
  end
end
