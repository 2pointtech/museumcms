class Table::MenusController < ApplicationController
  layout 'admin'

  # GET /table/menus
  # GET /table/menus.json
  def index
    @table_menus = Table::Menu.where(:site_id => params[:site_id])
    @site = Table::Site.find(params[:site_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @table_menus }
    end
  end

  # GET /table/menus/1
  # GET /table/menus/1.json
  def show
    @table_menu = Table::Menu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @table_menu }
    end
  end

  # GET /table/menus/new
  # GET /table/menus/new.json
  def new
    @table_menu = Table::Menu.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @table_menu }
    end
  end

  # GET /table/menus/1/edit
  def edit
    @table_menu = Table::Menu.find(params[:id])
  end

  # POST /table/menus
  # POST /table/menus.json
  def create
    @table_menu = Table::Menu.new(params[:table_menu])

    respond_to do |format|
      if @table_menu.save
        format.html do
          if params[:continue]
            redirect_to edit_table_menu_path(@table_menu)
          else
            redirect_to table_menus_path(:site_id => @table_menu.site_id)
          end
        end
        format.json { render json: @table_menu, status: :created, location: @table_menu }
      else
        format.html { render action: "new" }
        format.json { render json: @table_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /table/menus/1
  # PUT /table/menus/1.json
  def update
    @table_menu = Table::Menu.find(params[:id])

    respond_to do |format|
      if @table_menu.update_attributes(params[:table_menu])
        format.html { redirect_to table_menus_path(:site_id => @table_menu.site_id) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @table_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /table/menus/1
  # DELETE /table/menus/1.json
  def destroy
    @table_menu = Table::Menu.find(params[:id])
    @table_menu.destroy

    respond_to do |format|
      format.html { redirect_to table_menus_url }
      format.json { head :no_content }
    end
  end
end
