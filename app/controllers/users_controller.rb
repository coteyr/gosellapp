class UsersController < ApplicationController
  load_and_authorize_resource
  def index
    @users = User.all if current_user.admin?
    @users ||= current_user.group.users
  end
  def edit
    @user = User.find params[:id]
    @groups = Group.all if current_user.admin?
  end
  def update
    @user = User.find params[:id]
    if @user.update_attributes allowed_params[:user]
      redirect_to users_path
    else
      @groups = Group.all if current_user.admin?
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
    @groups = Group.all if current_user.admin?
  end
  def create
    @user = User.new
    if @user.update_attributes allowed_params[:user]
      redirect_to users_path
    else
      @groups = Group.all if current_user.admin?
      render action: 'new'
    end
  end
  def become
    if current_user.admin?
      sign_out(current_user)
      user = User.find params[:user_id]
      sign_in(user)
    end
    redirect_to '/'
  end

private
  def allowed_params
    # params.require(:location)
    params.permit(user: [:group_id, :id, :first_name, :last_name, :username, :email, :permission_level, :password, :password_confirmation])
  end
end
