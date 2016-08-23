class Theater::ShowingsController < ApplicationController
  layout 'admin'

  # GET /theater/showings
  # GET /theater/showings.json
  def index
    @theater_showings = Theater::Showing.rank(:row)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @theater_showings }
    end
  end

  # GET /theater/showings/1
  # GET /theater/showings/1.json
  def show
    @theater_showing = Theater::Showing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @theater_showing }
    end
  end

  # GET /theater/showings/new
  # GET /theater/showings/new.json
  def new
    @theater_showing = Theater::Showing.new
    @theater_showing.auto_play = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @theater_showing }
    end
  end

  # GET /theater/showings/1/edit
  def edit
    @theater_showing = Theater::Showing.find(params[:id])
  end

  # POST /theater/showings
  # POST /theater/showings.json
  def create
    @theater_showing = Theater::Showing.new(params[:theater_showing])

    respond_to do |format|
      if @theater_showing.save
        format.html { redirect_to theater_showings_path }
        format.json { render json: @theater_showing, status: :created, location: @theater_showing }
      else
        format.html { render action: "new" }
        format.json { render json: @theater_showing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /theater/showings/1
  # PUT /theater/showings/1.json
  def update
    @theater_showing = Theater::Showing.find(params[:id])

    respond_to do |format|
      if @theater_showing.update_attributes(params[:theater_showing])
        format.html { redirect_to theater_showings_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @theater_showing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /theater/showings/1
  # DELETE /theater/showings/1.json
  def destroy
    @theater_showing = Theater::Showing.find(params[:id])
    @theater_showing.destroy

    respond_to do |format|
      format.html { redirect_to theater_showings_url }
      format.json { head :no_content }
    end
  end
end
