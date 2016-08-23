class Classroom::SchedulesController < ApplicationController
  layout 'admin', :except => [:show]

  # GET /classroom/schedules
  # GET /classroom/schedules.json
  def index
    @classroom_schedules = Classroom::Schedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @classroom_schedules }
    end
  end

  # GET /classroom/schedules/1
  # GET /classroom/schedules/1.json
  def show
    @classroom_schedule = Classroom::Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @classroom_schedule.events }
    end
  end

  # GET /classroom/schedules/new
  # GET /classroom/schedules/new.json
  def new
    @classroom_schedule = Classroom::Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @classroom_schedule }
    end
  end

  # GET /classroom/schedules/1/edit
  def edit
    @classroom_schedule = Classroom::Schedule.find(params[:id])
  end

  # POST /classroom/schedules
  # POST /classroom/schedules.json
  def create
    @classroom_schedule = Classroom::Schedule.new(params[:classroom_schedule])

    respond_to do |format|
      if @classroom_schedule.save
        format.html { redirect_to classroom_schedules_path }
        format.json { render json: @classroom_schedule, status: :created, location: @classroom_schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @classroom_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /classroom/schedules/1
  # PUT /classroom/schedules/1.json
  def update
    @classroom_schedule = Classroom::Schedule.find(params[:id])

    respond_to do |format|
      if @classroom_schedule.update_attributes(params[:classroom_schedule])
        format.html { redirect_to classroom_schedules_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @classroom_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classroom/schedules/1
  # DELETE /classroom/schedules/1.json
  def destroy
    @classroom_schedule = Classroom::Schedule.find(params[:id])
    @classroom_schedule.destroy

    respond_to do |format|
      format.html { redirect_to classroom_schedules_url }
      format.json { head :no_content }
    end
  end
end
