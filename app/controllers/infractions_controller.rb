class InfractionsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:index, :new, :create]

  # GET /infractions
  # GET /infractions.xml
  def index
    # the list of infractions is within the scope of a game
    @infractions = current_game.infractions.paginate(:page => params[:page])
    # filter the infractions if the user limited the search to certain conditions
    @infraction_params = filter_params
    if @infraction_params.any?
      # Join with the witnesses table if we need to
      @infractions = @infractions.includes(:witnesses) if @infraction_params[:witnesses].any?
      @infractions = @infractions.where(@infraction_params)
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
    @infraction.status = (params[:infraction][:photo].nil?) ? Status.pending : Status.accepted
 
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
    respond_to do |format|
      if @infraction.update_attributes(params[:infraction])
        @infraction.check_status! unless current_user.player.is_admin?
        # send notification to player who created the infraction and to all players who belong to the offending team
        # we should only send notifications when the status of the infraction changes
        PlayerMailer.infraction_notification(@infraction, :updated) if @infraction.status_id_changed?

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
  
  private
  def filter_params
    if params[:infraction]
      # Do some validations on the filter fields:
      # 1. restrict search fields to only a certain list
      # 2. make sure we only take fields that have a value
      params[:infraction].keep_if do |field, value|
        [:team_id, :offender_id, :infraction_type_id, :status_id, :player_id, :witnesses].include?(field.to_sym) && value.present?
      end
    end

    params[:infraction] || {}
  end
end
