class InfractionTypesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => :create
  before_filter :permitted_params, :only => [:new, :edit]

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
    @infraction_type = InfractionType.new(infraction_type_params)
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
      if @infraction_type.update_attributes(infraction_type_params)
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
    begin
      @infraction_type.destroy
    rescue ActiveRecord::DeleteRestrictionError => exception
      flash[:error] = exception.message
    end

    respond_to do |format|
      format.html { redirect_to(infraction_types_url) }
      format.xml  { head :ok }
    end
  end

  private

  def permitted_params
    @permitted_params ||= [:name, :description, :points, :active, :hidden]
  end

  def infraction_type_params
    params.require(:infraction_type).permit(*permitted_params)
  end
end
