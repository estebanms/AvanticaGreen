class SuggestionTypesController < ApplicationController
  load_and_authorize_resource

  # GET /suggestion_types
  # GET /suggestion_types.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @suggestion_types }
    end
  end

  # GET /suggestion_types/1
  # GET /suggestion_types/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @suggestion_type }
    end
  end

  # GET /suggestion_types/new
  # GET /suggestion_types/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @suggestion_type }
    end
  end

  # GET /suggestion_types/1/edit
  def edit
  end

  # POST /suggestion_types
  # POST /suggestion_types.xml
  def create
    respond_to do |format|
      if @suggestion_type.save
        format.html { redirect_to(@suggestion_type, :notice => 'Suggestion type was successfully created.') }
        format.xml  { render :xml => @suggestion_type, :status => :created, :location => @suggestion_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @suggestion_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /suggestion_types/1
  # PUT /suggestion_types/1.xml
  def update
    respond_to do |format|
      if @suggestion_type.update_attributes(params[:suggestion_type])
        format.html { redirect_to(@suggestion_type, :notice => 'Suggestion type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @suggestion_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestion_types/1
  # DELETE /suggestion_types/1.xml
  def destroy
    @suggestion_type.destroy

    respond_to do |format|
      format.html { redirect_to(suggestion_types_url) }
      format.xml  { head :ok }
    end
  end
end
