class ImportsController < ApplicationController
  load_and_authorize_resource
  def new
    @import = Import.new
  end
  def create
    @import = Import.new
    if @import.update_attributes allowed_params[:import]
      redirect_to '/'
    else
      render action: 'new'
    end
  end
  def index
    @imports = Import.all
  end

private
  def allowed_params
    # params.require(:location)
    params.permit(import: [:id, :data, :user_id])
  end
end
