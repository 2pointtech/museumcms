class Table::SitesController < ApplicationController
  layout 'admin'

  # GET /table/sites
  # GET /table/sites.json
  def index
    @table_sites = Table::Site.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @table_sites }
    end
  end

  # GET /table/sites/1
  # GET /table/sites/1.json
  def show
    @table_site = Table::Site.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @table_site }
    end
  end

  # GET /table/sites/new
  # GET /table/sites/new.json
  def new
    @table_site = Table::Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @table_site }
    end
  end

  # GET /table/sites/1/edit
  def edit
    @table_site = Table::Site.find(params[:id])
  end

  # POST /table/sites
  # POST /table/sites.json
  def create
    @table_site = Table::Site.new(params[:table_site])

    respond_to do |format|
      if @table_site.save
        format.html do
          if params[:continue]
            redirect_to table_menus_path(:site_id => @table_site)
          else
            redirect_to table_sites_path
          end
        end
        format.json { render json: @table_site, status: :created, location: @table_site }
      else
        format.html { render action: "new" }
        format.json { render json: @table_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /table/sites/1
  # PUT /table/sites/1.json
  def update
    @table_site = Table::Site.find(params[:id])

    respond_to do |format|
      if @table_site.update_attributes(params[:table_site])
        format.html { redirect_to table_sites_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @table_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /table/sites/1
  # DELETE /table/sites/1.json
  def destroy
    @table_site = Table::Site.find(params[:id])
    @table_site.destroy

    respond_to do |format|
      format.html { redirect_to table_sites_url }
      format.json { head :no_content }
    end
  end
end
