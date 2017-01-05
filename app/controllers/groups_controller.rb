class GroupsController < ApplicationController
  load_and_authorize_resource
  def index
    @groups = Group.all
  end
  def new
    @group = Group.new
  end
  def create
    @group = Group.new
    if @group.update_attributes allowed_params[:group]
      redirect_to groups_path
    else
      render action: 'new'
    end
  end
  def update
    @group = Group.find params[:id]
    if @group.update_attributes allowed_params[:group]
      redirect_to groups_path
    else
      render action: 'edit'
    end
  end
private
  def allowed_params
    params.permit(group: [:name])
  end

end
