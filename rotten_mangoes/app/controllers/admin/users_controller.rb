class Admin::UsersController < ApplicationController

  before_action do
    restrict_admin_access
  end

  def index
    @users = User.order(:id).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      redirect_to admin_users_path, notice: "User successfully saved!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User ID: #{@user.id} was successfully updated."
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.deleted_user(@user).deliver
    redirect_to admin_users_path, notice: "User #{@user.full_name} successfully deleted!"
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
