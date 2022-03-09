class ApplicationController < ActionController::Base
  # before_action :set_locale
  before_action :set_ransack_obj

  private
  # def set_locale
  #   # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
  #   if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
  #     session[:locale] = params[:locale]
  #   end
  
  #   I18n.locale = session[:locale] || I18n.default_locale
  # end

  def set_ransack_obj
    @q = Task.ransack(params[:q])
  end


end
