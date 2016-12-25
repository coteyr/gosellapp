class ProspectsController < ApplicationController
  before_action :set_prospect, only: [:show, :edit, :edit_contacts, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:home]

  def index
    terms = {}
    primary_terms = {}
    if value = params[:loc] || session[:loc]
      session[:loc] = params[:loc] if params[:loc]
      terms = ['address like ?', "%#{value}%"]
    elsif value = params[:co] || session[:co]
      session[:co] = params[:co] if params[:co]
      terms = ['company like ?', "%#{value}%"]
    elsif value =  params[:phon] || session[:phon]
      session[:phon] = params[:phon] if params[:phon]
      terms = ['company_phone like ?', "#{value}"]
    end
    if params[:list_number]
      primary_terms.merge!(list_number: params[:list_number])
      @goList = Prospect.select(:list_number).order(:list_number).distinct
    end
    if params[:go] == 'walk' or params[:go] == 'smile'
      @prospect = current_user.prospects.unlocked.uncalled.where(terms).where(primary_terms).first if params[:go] == 'smile'
      @prospect = current_user.prospects.unlocked.uncanvassed.where(terms).where(primary_terms).first if params[:go] == 'walk'
      if @prospect
        @prospect.update_column :locked_at, DateTime.now
        render action: (params[:go] == 'walk' ? 'canvass' : 'call') # when I know more about these different views I suspect that they will different partials on show and we can loose this smell.
      else
        @prospects = []
        redirect_to root_url, notice: 'All Prospects Viewed'
      end
    else
      @prospects = current_user.prospects.where(terms).where(primary_terms).page(params[:page]).per(10)
      respond_to do |format|
        format.html
        format.csv { send_data @prospects.to_csv(['user_id', 'campaign', 'list_number', 'source', 'company_phone', 'company', 'first_name', 'last_name', 'title', 'address', 'address2', 'city', 'state', 'zip', 'county', 'fax', 'numberofemployees', 'website', 'sic']) }
      end
    end
  end
  # Following 4 lines for importing from csv
  def import
    Prospect.import(params[:file])
    redirect_to root_url, notice: "Prospects imported."
  end

  # Allowing for nested form to create results and notes
  def show
    @result = Result.new
    @note = Note.new
  end

  def new
    @prospect = Prospect.new
  end

  def create
    @prospect = Prospect.new(prospect_params)
    respond_to do |format|
      if @prospect.save
        format.html { redirect_to @prospect, notice: 'New Prospect was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    @prospect = Prospect.find params[:id]
    if @prospect.update_attributes(prospect_params)
      @prospect.update_column :canvassed, true if params[:go] == 'walk'
      @prospect.update_column :called, true if params[:go] == 'smile'
      redirect_to prospects_path(go: params[:go])
    else
      render :show
    end
  end

  def destroy
    @prospect.destroy
    redirect_to prospects_url, notice: 'Prospect was successfully deleted.'
  end

  def reset
    for prospect in current_user.prospects
      if prospect.results.last and !["appointment", "follow-up", "not-qualified", "bad-record"].include? prospect.results.last.disposition
        prospect.update_column :canvassed, false if params[:go] == 'walk'
        prospect.update_column :called, false if params[:go] == 'smile'
      end
    end
    redirect_to root_url, notice: 'Prospects have been reset'
  end

  def delete_list
  end
  def list_delete
    # this is the actual delete method on post
    for prospect in current_user.prospects.where(list_number: params[:list])
      prospect.destroy
    end
    redirect_to root_url, notice: 'List deleted'
  end



private
  def set_prospect
    @prospect = Prospect.find(params[:id])
  end

  def prospect_params
    params
        .require(:prospect)
        .permit(:campaign, :list_number, :time_on_contact, :status, :source,
                :company, :company_phone, :address, :address2, :city, :state,
                :zip, :county, :fax, :website, :numberofemployees, :first_name,
                :last_name, :title, :phone, :m_phone, :email, :alt_email,
                :linkedin, :facebook, :born_on, :first_name_2, :last_name_2,
                :title_2, :phone_2, :m_phone_2, :email_2, :alt_email_2,
                :linkedin_2, :facebook_2, :born_on_2, :first_name_3,
                :last_name_3, :title_3, :phone_3, :m_phone_3, :email_3,
                :alt_email_3, :linkedin_3, :facebook_3, :born_on_3, :other1,
                :other2, :other3, :other4, :other5, :other6, :other7, :other8,
                :eventdatetime, :sic, :primary_contact, :canvassed, :called, :user_id,
                notes_attributes: [:detail],
                results_attributes: [:id, :disposition, :event, :activity,
                :coordinates, :latitude, :longitude,:location, :user_id])
  end
end
