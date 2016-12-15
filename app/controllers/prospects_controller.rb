class ProspectsController < ApplicationController
  before_action :set_prospect, only: [:show, :edit, :edit_contacts, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:home]

  def index
    terms = {}
    primary_terms = {}
    if params[:loc]
      terms = ['address like ?', "%#{params[:loc]}%"]
    elsif params[:co]
      terms = ['company like ?', "%#{params[:co]}%"]
    elsif params[:phon]
      terms = ['company_pone like ?', "#{params{:phon}}"]
    end
    if params[:list_number]
      primary_terms.merge!(list_number: params[:list_number])
      @goList = Prospect.select(:list_number).order(:list_number).distinct
    end
    @prospects = current_user.prospects.where(terms).where(primary_terms).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.csv { send_data @prospects.to_csv(['user_id', 'campaign', 'list_number', 'source', 'company_phone', 'company', 'first_name', 'last_name', 'title', 'address', 'address2', 'city', 'state', 'zip', 'county', 'fax', 'numberofemployees', 'website', 'sic']) }
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
    respond_to do |format|
      if @prospect.update(prospect_params)
        format.html { redirect_to @prospect, notice: 'Prospect was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @prospect.destroy
    respond_to do |format|
      format.html { redirect_to prospects_url, notice: 'Prospect was successfully deleted.' }
    end
  end

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
