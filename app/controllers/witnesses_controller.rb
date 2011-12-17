class WitnessesController < ApplicationController
  include WitnessesHelper
  before_filter :get_infraction
  load_and_authorize_resource
  skip_load_resource :only => [:index, :new, :create]
  
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
    respond_to do |format|
      format.html # show.html.erb
      format.js # show.js.erb
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
      format.js # new.js.erb
      format.xml  { render :xml => @witness }
    end
  end

  # GET /witnesses/1/edit
  def edit
  end

  # POST /witnesses
  # POST /witnesses.xml
  def create
    @witness = Witness.new(params[:witness])
    @witness.infraction = @infraction
    @witness.status = @infraction.status = Status.pending
    @witnesses_size = Witness.count(:conditions => "infraction_id = #{@infraction.id}")

    respond_to do |format|
      if @witness.save
        # notify player by email he has been added as a witness
        PlayerMailer.witness_notification(@witness, 'added').deliver

        format.html { redirect_to(@witness, :notice => 'Witness was successfully created.') }
        format.js
        format.xml  { render :xml => @witness, :status => :created, :location => @witness }
      else
        format.html { render :action => "new" }
        format.js   { render :action => 'errors' }
        format.xml  { render :xml => @witness.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /witnesses/1
  # PUT /witnesses/1.xml
  def update
    respond_to do |format|
      if @witness.update_attributes(params[:witness])
        format.html { redirect_to(@witness, :notice => 'Witness was successfully updated.') }
        format.js   { render :action => 'show' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js   { render :action => 'errors' }
        format.xml  { render :xml => @witness.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /witnesses/1
  # DELETE /witnesses/1.xml
  def destroy
    begin
      @witness.destroy
    rescue ActiveRecord::DeleteRestrictionError => exception
      @witness.errors.add(:infraction, exception.message)
    end

    # notify player by email he has been removed as a witness
    PlayerMailer.witness_notification(@witness, 'removed').deliver

    @witnesses_size = Witness.count(:conditions => "infraction_id = #{@infraction.id}")
    respond_to do |format|
      format.html { redirect_to(witnesses_url) }
      format.js   { render :action => @witness.errors.any? ? 'errors' : 'destroy' }
      format.xml  { head :ok }
    end
  end

  def update_status
    @witness = Witness.find(params[:witness_id])
    @witness.status = Status.find(params[:status_id])
    respond_to do |format|
      if @witness.update_attributes(params[:witness])
        format.html { redirect_to(@witness.player) }
        format.xml  { head :ok } 
      else
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @witness.errors, :status => :unprocessable_entity }
      end
    end
  end

private
  def get_infraction
    @infraction = Infraction.find(params[:infraction_id])
  end
end
