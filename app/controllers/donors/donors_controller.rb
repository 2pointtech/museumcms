class Donors::DonorsController < ApplicationController
  layout 'admin'

  # GET /donors/donors
  # GET /donors/donors.json
  def index
    @donors_donors = Donors::Donor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @donors_donors }
    end
  end

  # GET /donors/donors/1
  # GET /donors/donors/1.json
  def show
    @donors_donor = Donors::Donor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @donors_donor }
    end
  end

  # GET /donors/donors/new
  # GET /donors/donors/new.json
  def new
    @donors_donor = Donors::Donor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @donors_donor }
    end
  end

  # GET /donors/donors/1/edit
  def edit
    @donors_donor = Donors::Donor.find(params[:id])
  end

  # POST /donors/donors
  # POST /donors/donors.json
  def create
    @donors_donor = Donors::Donor.new(params[:donors_donor])

    respond_to do |format|
      if @donors_donor.save
        format.html { redirect_to donors_donors_path }
        format.json { render json: @donors_donor, status: :created, location: @donors_donor }
      else
        format.html { render action: "new" }
        format.json { render json: @donors_donor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /donors/donors/1
  # PUT /donors/donors/1.json
  def update
    @donors_donor = Donors::Donor.find(params[:id])

    respond_to do |format|
      if @donors_donor.update_attributes(params[:donors_donor])
        format.html { redirect_to donors_donors_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @donors_donor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donors/donors/1
  # DELETE /donors/donors/1.json
  def destroy
    @donors_donor = Donors::Donor.find(params[:id])
    @donors_donor.destroy

    respond_to do |format|
      format.html { redirect_to donors_donors_url }
      format.json { head :no_content }
    end
  end
end
