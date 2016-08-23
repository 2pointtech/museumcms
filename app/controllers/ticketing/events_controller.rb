class Ticketing::EventsController < ApplicationController
  layout 'admin'

  # GET /ticketing/events
  # GET /ticketing/events.json
  def index
    @ticketing_events = Ticketing::Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticketing_events }
    end
  end

  # GET /ticketing/events/1
  # GET /ticketing/events/1.json
  def show
    @ticketing_event = Ticketing::Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticketing_event }
    end
  end

  # GET /ticketing/events/new
  # GET /ticketing/events/new.json
  def new
    @ticketing_event = Ticketing::Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticketing_event }
    end
  end

  # GET /ticketing/events/1/edit
  def edit
    @ticketing_event = Ticketing::Event.find(params[:id])
  end

  # POST /ticketing/events
  # POST /ticketing/events.json
  def create
    @ticketing_event = Ticketing::Event.new(params[:ticketing_event])

    respond_to do |format|
      if @ticketing_event.save
        format.html { redirect_to ticketing_events_path }
        format.json { render json: @ticketing_event, status: :created, location: @ticketing_event }
      else
        format.html { render action: "new" }
        format.json { render json: @ticketing_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ticketing/events/1
  # PUT /ticketing/events/1.json
  def update
    @ticketing_event = Ticketing::Event.find(params[:id])

    respond_to do |format|
      if @ticketing_event.update_attributes(params[:ticketing_event])
        format.html { redirect_to ticketing_events_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticketing_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticketing/events/1
  # DELETE /ticketing/events/1.json
  def destroy
    @ticketing_event = Ticketing::Event.find(params[:id])
    @ticketing_event.destroy

    respond_to do |format|
      format.html { redirect_to ticketing_events_url }
      format.json { head :no_content }
    end
  end
end
