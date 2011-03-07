class InfractionsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:index, :new, :create]

  # GET /infractions
  # GET /infractions.xml
  def index
    # the list of infractions is within the scope of a game
    # TODO: add filters to let the user see infractions from other games, dates, types (open only, ...), etc
    @infractions = current_game.infractions rescue Array.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @infractions }
    end
  end

  # GET /infractions/1
  # GET /infractions/1.xml
  def show
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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @infraction }
    end
  end

  # GET /infractions/1/edit
  def edit
    @anonymous = @infraction.anonymous?
  end

  # POST /infractions
  # POST /infractions.xml
  def create
    @anonymous = params[:anonymous]
    @infraction = Infraction.new(params[:infraction])
    @infraction.game = current_game
    @infraction.player = current_player unless @anonymous
    @infraction.team = current_player.team rescue nil
    @infraction.status = Status.find_by_name('Pending revision')
     
    respond_to do |format|
      if @infraction.save
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
    # update current player if the anonymous flag is not set
    @anonymous = params[:anonymous]
    params[:infraction][:player_id] = @anonymous ? nil : current_player.id

    respond_to do |format|
      if @infraction.update_attributes(params[:infraction])
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
