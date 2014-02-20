class TeamsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:index, :create]
  before_filter :permitted_params, :only => [:new, :edit]

  # GET /teams
  # GET /teams.xml
  def index
    @teams_sorted = Team.sorted_by_score
    @top_reporters = Team.top_reporters
    @inactive_teams = Team.inactive if can? :manage, Team

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    if params['tooltip'].nil?
      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @team }
      end
    else # show ajax tooltip
      render :partial => 'shared/tooltip', :locals => {
        :image => @team.team_logo.url(:thumb),
        :simple_data => { 'Team name' => @team.name, 'Score' => @team.score },
        :collection => { 'Members' => @team.players.collect { |player| player.full_name } }
      }
    end
  end

  # GET /teams/new
  # GET /teams/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.xml
  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to(@team, :notice => 'Team was successfully created.') }
        format.xml  { render :xml => @team, :status => :created, :location => @team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.xml
  def update
    respond_to do |format|
      if @team.update_attributes(team_params)
        format.html { redirect_to(@team, :notice => 'Team was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.xml
  def destroy
    begin
      @team.destroy
    rescue ActiveRecord::DeleteRestrictionError => exception
      flash[:error] = exception.message
    end

    respond_to do |format|
      format.html { redirect_to(teams_url) }
      format.xml  { head :ok }
    end
  end

  private

  def permitted_params
    unless @permitted_params
      @permitted_params = [:team_logo, :name, :description]
      if can?(:manage, @team || Team)
        @permitted_params += [:code, :active]
      end
    end
    @permitted_params
  end

  def team_params
    params.require(:team).permit(*permitted_params)
  end
end
