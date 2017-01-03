class UsersController < ApplicationController
  load_and_authorize_resource
  def index
    @users = User.all
  end
  def edit
    @user = User.find params[:id]
  end
  def update
    @user = User.find params[:id]
    if @user.update_attributes allowed_params[:user]
      redirect_to users_path
    else
      render action: 'edit'
    end
  end
  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to users_path
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new
    if @user.update_attributes allowed_params[:user]
      redirect_to users_path
    else
      render action: 'new'
    end
  end

private
  def allowed_params
    # params.require(:location)
    params.permit(user: [:id, :first_name, :last_name, :username, :email, :permission_level, :password, :password_confirmation])
  end
end
