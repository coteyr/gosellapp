class MenuController < ApplicationController
  def index
    session[:loc] = nil
    session[:co]  = nil
    session[:phon] = nil
    session[:list_number] = nil
  end
end
