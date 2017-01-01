class MenuController < ApplicationController
  def index
    session[:loc] = nil
    session[:co]  = nil
    session[:phon] = nil
    session[:list_id] = nil
  end
end
