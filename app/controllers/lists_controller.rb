class ListsController < ApplicationController
  load_and_authorize_resource
  def index
    @lists = List.all
  end
  def reset
    list = List.find params[:list_id]
    list.prospects.update_all(called: false, canvassed: false)
    redirect_to lists_path, notice: 'Prospects have been reset'
  end
  def destroy
    list = List.find params[:id]
    list.destroy
    redirect_to lists_path, notice: 'Prospects have been deleted'
  end
end
