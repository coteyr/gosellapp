class ResultsController < ApplicationController

  def create
    @prospect = Prospect.find params[:prospect_id]
    @result = @prospect.results.new
    @result.prospect = @prospect
    if @result.update_attributes result_params
      @note = @prospect.notes.new
      @note.detail = params[:note]
      @note.save
      @prospect.update_column :canvassed, true if params[:go] == 'walk'
      @prospect.update_column :called, true if params[:go] == 'smile'
      redirect_to prospects_path(go: params[:go]), notice: 'Result was successfully posted.'
    else
      render action: 'prospects/show'
    end
  end

  def new
    @result = Result.new
  end


  private
  def result_params
      params.require(:result).permit(:disposition, :accessible, :event, :location, :prospect_id, :user_id)
  end
end
