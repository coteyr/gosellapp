class JobsController < ApplicationController
  def index
    @jobs = DelayedJob.all
  end
  def show
    @job = DelayedJob.find params[:id]
  end
end
