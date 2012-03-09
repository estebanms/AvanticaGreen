class PlayersController < ApplicationController
  load_and_authorize_resource

  # GET /players
  # GET /players.xml
  def index
    @players = Player.where(:active => true) unless user_signed_in? && current_player.is_admin?
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    # show all the accepted infractions created by this player, except the anonymous ones
    @player_infractions = @player.infractions.accepted.reject { |infraction| infraction.anonymous? }
    # also show all the information regarding this player being a witness
    @witnesses = @player.witnesses
    @pending_witnesses = @witnesses.select { |witness| pending?(witness) }
    @accepted_witnesses = @witnesses.select { |witness| accepted?(witness) }
    @rejected_witnesses = @witnesses.select { |witness| rejected?(witness) }
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/new
  # GET /players/new.xml
  def new
    @player.user_id = params[:user_id]
    respond_to do |format|
      format.html {
        redirect_to(new_user_registration_path, :notice => 'You need to create a user first.') unless @player.user
        # else new.html.erb
      }
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.xml
  def create
    # automatically create a new team for the user if there isn't one already
    unless @player.team || @player.name.blank?
      team = Team.find_or_initialize_by_name_and_code("#{@player.name}'s Team", @player.name.upcase)
      @player.team = team if team.save
    end
    respond_to do |format|
      if @player.save
        format.html { redirect_to(@player, :notice => 'Player was successfully created.') }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        team.destroy if team
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.xml
  def update
    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to(@player, :notice => 'Player was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.xml
  def destroy
    @player.destroy

    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end
end
