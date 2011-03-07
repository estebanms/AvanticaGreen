class InfractionTypesController < ApplicationController
  load_and_authorize_resource

  # GET /infraction_types
  # GET /infraction_types.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @infraction_types }
    end
  end

  # GET /infraction_types/1
  # GET /infraction_types/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @infraction_type }
    end
  end

  # GET /infraction_types/new
  # GET /infraction_types/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @infraction_type }
    end
  end

  # GET /infraction_types/1/edit
  def edit
  end

  # POST /infraction_types
  # POST /infraction_types.xml
  def create
    respond_to do |format|
      if @infraction_type.save
        format.html { redirect_to(@infraction_type, :notice => 'Infraction type was successfully created.') }
        format.xml  { render :xml => @infraction_type, :status => :created, :location => @infraction_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @infraction_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /infraction_types/1
  # PUT /infraction_types/1.xml
  def update
    respond_to do |format|
      if @infraction_type.update_attributes(params[:infraction_type])
        format.html { redirect_to(@infraction_type, :notice => 'Infraction type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @infraction_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /infraction_types/1
  # DELETE /infraction_types/1.xml
  def destroy
    @infraction_type.destroy

    respond_to do |format|
      format.html { redirect_to(infraction_types_url) }
      format.xml  { head :ok }
    end
  end
end
