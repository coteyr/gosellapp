class MenuController < ApplicationController
  def index
    authorize! :show, current_user
    session[:loc] = nil
    session[:co]  = nil
    session[:phon] = nil
    session[:list_id] = nil
    @lists = current_user.lists
  end
end
