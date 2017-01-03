class ListsController < ApplicationController
  load_and_authorize_resource
  def index
    @lists = List.all
  end
  def reset
    list = List.find params[:list_id]
    for prospect in list.prospects
      if prospect.results.where(disposition: %w(appointment follow-up not-qualified bad-record sale no-sale)).count == 0
        prospect.update_column(:called, false)
        prospect.update_column(:canvassed, false)
      end
    end
    redirect_to lists_path, notice: 'Prospects have been reset'
  end
  def destroy
    list = List.find params[:id]
    list.destroy
    redirect_to lists_path, notice: 'Prospects have been deleted'
  end
end
