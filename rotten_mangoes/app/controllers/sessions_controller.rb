class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to movies_path
    else
      redirect_to new_session_path, notice: "Wrong email/password combination."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "Adios!"
  end

  def spoof
    user = User.find(params[:id])
    if current_user.is_admin?
      session[:admin_id] = session[:user_id] 
      session[:user_id] = user.id
      redirect_to movies_path
    else
      redirect_to movies_path, notice: "Admins only."
    end
  end

  def end_spoof
    if is_spoofing?
      session[:user_id] = session[:admin_id]
      session[:admin_id] = nil
      current_user
    end
    redirect_to admin_users_path
  end

end
