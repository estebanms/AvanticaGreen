class WitnessesController < ApplicationController
  include WitnessesHelper
  before_filter :get_infraction
  
  # GET /witnesses
  # GET /witnesses.xml
  def index
    @witnesses = @infraction.witnesses

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @witnesses }
    end
  end

  # GET /witnesses/1
  # GET /witnesses/1.xml
  def show
    @witness = Witness.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @witness }
    end
  end

  # GET /witnesses/new
  # GET /witnesses/new.xml
  def new
    @witness = Witness.new
    @witness.infraction = @infraction

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @witness }
    end
  end

  # GET /witnesses/1/edit
  def edit
    @witness = Witness.find(params[:id])
  end

  # POST /witnesses
  # POST /witnesses.xml
  def create
    @witness = Witness.new(params[:witness])
    @witness.infraction = @infraction

    respond_to do |format|
      if @witness.save
        format.html { redirect_to(@witness, :notice => 'Witness was successfully created.') }
        format.xml  { render :xml => @witness, :status => :created, :location => @witness }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @witness.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /witnesses/1
  # PUT /witnesses/1.xml
  def update
    @witness = Witness.find(params[:id])

    respond_to do |format|
      if @witness.update_attributes(params[:witness])
        format.html { redirect_to(@witness, :notice => 'Witness was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @witness.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /witnesses/1
  # DELETE /witnesses/1.xml
  def destroy
    @witness = Witness.find(params[:id])
    @witness.destroy

    respond_to do |format|
      format.html { redirect_to(witnesses_url) }
      format.xml  { head :ok }
    end
  end

private
  def get_infraction
    @infraction = Infraction.find(params[:infraction_id])
  end
end
