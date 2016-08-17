class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def restrict_admin_access
    unless current_user && current_user.is_admin?
      flash[:alert] = "Only admins can access this page!"
      redirect_to movies_path
    end
  end

  def restrict_access
    if !current_user
      flash[:alert] =  "You must log in."
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_spoofing?
    session[:admin_id] != nil
  end
  
  private

    helper_method :current_user
    helper_method :is_spoofing?
    helper_method :end_spoofing
    
end
