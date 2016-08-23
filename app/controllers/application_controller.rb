class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    if Rails.application.config.admin_user and !session[:logged_in]
      if user = authenticate_with_http_basic { |u, p| u == Rails.application.config.admin_user and p == Rails.application.config.admin_password }
        session[:logged_in] = true
      else
        request_http_basic_authentication
      end
    end
  end
end
