class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    #current_user.locale
    #request.env["HTTP_ACCEPT_LANGUAGE"]
  end

  def default_url_options(options = {})
    {locale: I18n.locale }.merge options
  end

  def page_from_params
    @page = params[:page] = [params[:page].to_i, 1].max
    @per_page = params[:limit] = params[:limit].present? ? params[:limit].to_i : 25
  end
  
end
