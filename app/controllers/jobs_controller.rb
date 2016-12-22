class JobsController < ApplicationController
  def index
    @jobs = Delayed::Job.all
  end
  def show
    @job = Delayed::Job.find params[:id]
  end
end
