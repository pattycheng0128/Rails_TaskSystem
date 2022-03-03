class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_ransack_obj
  helper_method :user_signed_in?, :current_user

  private
  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end
  
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def set_ransack_obj
    @q = Task.ransack(params[:q])
  end

  def user_signed_in?
    session[:user_session].present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_session])
  end

  def authenticate_user!
    redirect_to sign_in_path, notice: '請先登入會員' unless user_signed_in?
  end
end
