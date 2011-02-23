class InfractionsController < ApplicationController
  # GET /infractions
  # GET /infractions.xml
  
  
  
  def index
    
    unless current_user.nil?
      show_open_only = ((params[:show_open].nil? || params[:show_open] == 0)  ? false : true)
      conditions ='where 1 = 1 '
      conditions = conditions +" and offender_id = #{current_user.player.team_id}" unless is_admin? #non-admins will see infractions commited by team only
      conditions = conditions +' and status_id = 1' if show_open_only
      
      #debo investigar si hay una forma de usar active record para concatenar condiciones para no usar find_by_sql
      @infractions = Infraction.find_by_sql('select * from infractions '+conditions)
    else
      @infractions = Infraction.all
      respond_to do |format|
	format.html # index.html.erb
	format.xml  { render :xml => @infractions }
      end
    end
  end

  # GET /infractions/1
  # GET /infractions/1.xml
  def show
    @infraction = Infraction.find(params[:id])

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
    @infraction = Infraction.find(params[:id])
    @infraction.status = Status.find_by_name("Pending revision")
  end

  # POST /infractions
  # POST /infractions.xml
  def create
    @infraction = Infraction.new(params[:infraction])
    @infraction.game = current_game
    @infraction.player = current_player
    @infraction.team = current_player.team rescue nil
    @infraction.status = Status.find_by_name("Pending revision")
     
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
    @infraction = Infraction.find(params[:id])

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
    @infraction = Infraction.find(params[:id])
    @infraction.destroy

    respond_to do |format|
      format.html { redirect_to(infractions_url) }
      format.xml  { head :ok }
    end
  end
end
