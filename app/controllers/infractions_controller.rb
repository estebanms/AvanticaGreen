class InfractionsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:index, :new, :create]

  # GET /infractions
  # GET /infractions.xml
  def index
    # the list of infractions is within the scope of a game
    @infractions = current_game.infractions rescue Array.new
    # filter the infractions if the user limited the search to certain conditions
    if params[:infraction]
      # do some validations on the filter fields
      # 1. restrict search fields to only: team_id, offender_id, infraction_type and status_id
      params[:infraction].keep_if do |field, value|
        [:team_id, :offender_id, :infraction_type_id, :status_id].include?(field.to_sym) and !value.blank?
      end
      @infractions = @infractions.where(params[:infraction]) unless params[:infraction].empty?
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @infractions }
    end
  end

  # GET /infractions/1
  # GET /infractions/1.xml
  def show
    @witnesses = @infraction.witnesses
    @commentable = @infraction
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @infraction }
    end
  end

  # GET /infractions/new
  # GET /infractions/new.xml
  def new
    @infraction = Infraction.new
    @infraction.game = current_game
    @infraction.player = current_player
    @infraction.team = current_player.team rescue nil
    @infraction.status = Status.pending

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @infraction }
    end
  end

  # GET /infractions/1/edit
  def edit
  end

  # POST /infractions
  # POST /infractions.xml
  def create
    @infraction = Infraction.new(params[:infraction])
    @infraction.game = current_game
    @infraction.player = current_player
    @infraction.team = current_player.team rescue nil
    @infraction.status = Status.pending
     
    respond_to do |format|
      if @infraction.save
        # send notification to player who created the infraction and to all players who belong to the offending team
        PlayerMailer.infraction_notification(@infraction, :created)
        format.html { redirect_to(@infraction, :notice => 'Infraction was successfully created.') }
        format.xml  { render :xml => @infraction, :status => :created, :location => @infraction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @infraction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /infractions/1
  # PUT /infractions/1.xml
  def update
    # we should only send notifications when the status of the infraction changes
    send_notification = @infraction.status_changed?
    respond_to do |format|
      if @infraction.update_attributes(params[:infraction])
        # send notification to player who created the infraction and to all players who belong to the offending team
        PlayerMailer.infraction_notification(@infraction, :updated) if send_notification

        format.html { redirect_to(@infraction, :notice => 'Infraction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @infraction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /infractions/1
  # DELETE /infractions/1.xml
  def destroy
    @infraction.destroy

    respond_to do |format|
      format.html { redirect_to(infractions_url) }
      format.xml  { head :ok }
    end
  end
end
