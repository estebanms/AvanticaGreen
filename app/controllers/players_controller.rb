require 'ldap'

class PlayersController < ApplicationController
  include StatusesHelper

  load_and_authorize_resource

  # GET /players
  # GET /players.xml
  def index
    @players = Player.joins(:team).where(:players => { :active => true }, :teams => { :active => true }) unless user_signed_in? && current_player.is_admin?
    @players = @players.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    # show all the accepted infractions created by this player
    @player_infractions = @player.infractions.accepted
    # but hide the anonymous infractions when seeing by any person other than the creator
    @player_infractions.reject! { |infraction| infraction.anonymous? } unless @player.user == current_user

    # also show all the information regarding this player being a witness
    @witnesses = @player.witnesses
    @pending_witnesses = @witnesses.select { |witness| pending?(witness) }
    @accepted_witnesses = @witnesses.select { |witness| accepted?(witness) }
    @rejected_witnesses = @witnesses.select { |witness| rejected?(witness) }

    if params['tooltip'].nil?
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @player }
      end
    else # show ajax tooltip
      render :partial => 'shared/tooltip', :locals => {
        :image => @player.avatar.url(:thumb), :simple_data => {
          'Player name' => @player.full_name, 'Team' => @player.team.to_s
        }, :collection => nil
      }
    end
  end

  # GET /players/new
  # GET /players/new.xml
  def new
    @player.user_id = params[:user_id]
    respond_to do |format|
      format.html # new.html.erb
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
    User.find(@player.user_id).destroy
    #@player.destroy

    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end

  def import
    number_of_players = params[:number_of_players].to_i
    @new_players = Array.new
    @rejected_players = Array.new
    all_ldap_users = Ldap.find_all_ldap_users(number_of_players)
    #loop through ldap users. If we find a non existent user in the User table, create it and add him to the Player table
    all_ldap_users.each do |player|
      if valid_ldap_user?(player) && !User.where(:email => player["mail"]).exists?
        user = User.new(:email => player["mail"].ldap_escape!)
        user.password = 'dummy1'
        user.save!
        Player.new(:name => player["name"].ldap_escape!, :last_names => player["last_names"].ldap_escape!, :user_id => user.id, 
          :team_id => Team.where(name: 'Available Players').id, 
          :is_admin => false, :active => true).save!
        @new_players.push(player)
      else
        @rejected_players.push(player)
      end
    end
  end

  private
  
  def valid_ldap_user?(args)
    if(args["name"].empty? || args["last_names"].empty? || args["mail"].empty? || !args["mail"].include?('@avantica.net'))
      false
    else
      true
    end
  end

end
