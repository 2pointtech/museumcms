class Ticketing::TicketsController < ApplicationController
  layout 'admin'

  # GET /ticketing/tickets
  # GET /ticketing/tickets.json
  def index
    @ticketing_tickets = Ticketing::Ticket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticketing_tickets }
    end
  end

  # GET /ticketing/tickets/1
  # GET /ticketing/tickets/1.json
  def show
    @ticketing_ticket = Ticketing::Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticketing_ticket }
    end
  end

  # GET /ticketing/tickets/new
  # GET /ticketing/tickets/new.json
  def new
    @ticketing_ticket = Ticketing::Ticket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticketing_ticket }
    end
  end

  # GET /ticketing/tickets/1/edit
  def edit
    @ticketing_ticket = Ticketing::Ticket.find(params[:id])
  end

  # POST /ticketing/tickets
  # POST /ticketing/tickets.json
  def create
    @ticketing_ticket = Ticketing::Ticket.new(params[:ticketing_ticket])

    respond_to do |format|
      if @ticketing_ticket.save
        format.html { redirect_to ticketing_tickets_path }
        format.json { render json: @ticketing_ticket, status: :created, location: @ticketing_ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticketing_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ticketing/tickets/1
  # PUT /ticketing/tickets/1.json
  def update
    @ticketing_ticket = Ticketing::Ticket.find(params[:id])

    respond_to do |format|
      if @ticketing_ticket.update_attributes(params[:ticketing_ticket])
        format.html { redirect_to ticketing_tickets_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticketing_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticketing/tickets/1
  # DELETE /ticketing/tickets/1.json
  def destroy
    @ticketing_ticket = Ticketing::Ticket.find(params[:id])
    @ticketing_ticket.destroy

    respond_to do |format|
      format.html { redirect_to ticketing_tickets_url }
      format.json { head :no_content }
    end
  end
end
