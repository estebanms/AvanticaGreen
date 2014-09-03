require 'ldap'

class PlayersController < ApplicationController
  include StatusesHelper

  load_and_authorize_resource
  skip_load_resource :only => :create
  before_filter :permitted_params, :only => [:new, :edit]

  # GET /players
  # GET /players.xml
  def index
    # If the user is an admin, it loads all players by default, not just the active ones
    @players = @players.joins(:team).where(:players => { :active => true }, :teams => { :active => true }) unless user_signed_in? && current_player.is_admin?
    @players = @players.paginate(:page => params[:page])

    # filter the players if the user limited the search to certain conditions
    @player_params = filter_params

    if @player_params.any?
      # the email field is part of the users table, so map it accordingly
      if @player_params[:email]
        @players = @players.joins(:user).where(users: { email: @player_params[:email] })
      end

      player_fields = @player_params.dup
      # We already processed the email, so ignore it
      player_fields.delete(:email)

      # We don't want an exact match, instead we would like to do a "starts with" comparison
      conditions = [player_fields.keys.map { |field| "players.#{field} LIKE ?" }.join(' AND ')]
      conditions += player_fields.values.map { |value| "#{value}%" }
      @players = @players.where(*conditions)
    end

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
    unless @player.user == current_user
      @player_infractions = @player_infractions.where('anonymous != ?', true)
    end

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
    @player.user = current_user
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
    @player = Player.new(player_params)
    @player.user = current_user
    # automatically create a new team for the user if there isn't one already
    unless @player.team || @player.name.blank?
      team = Team.find_or_initialize_by(name: "#{@player.name}'s Team", code: @player.name.upcase)
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
      if @player.update_attributes(player_params)
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
    @player.user.destroy

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
          :team_id => Team.where(name: 'Available Players').first.id, 
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

  def filter_params
    # Do some validations on the filter fields:
    # 1. restrict search fields to only a certain list
    # 2. make sure we only take fields that have a value
    player_params = params.dup
    player_params.keep_if do |field, value|
      [:email, :name, :last_names].include?(field.to_sym) && value.present?
    end

    player_params || {}
  end

  def permitted_params
    unless @permitted_params
      @permitted_params = [:avatar, :name, :last_names]
      if can?(:manage, @player || Player)
        @permitted_params += [:active, :team_id, :is_admin]
      end
    end
    @permitted_params
  end

  def player_params
    params.require(:player).permit(*permitted_params)
  end

end

