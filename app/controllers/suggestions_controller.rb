class SuggestionsController < ApplicationController
  load_and_authorize_resource

  # GET /suggestions
  # GET /suggestions.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @suggestions }
    end
  end

  # GET /suggestions/1
  # GET /suggestions/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @suggestion }
    end
  end

  # GET /suggestions/new
  # GET /suggestions/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @suggestion }
    end
  end

  # GET /suggestions/1/edit
  def edit
  end

  # POST /suggestions
  # POST /suggestions.xml
  def create
    @suggestion.player = current_player

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to(@suggestion, :notice => 'Suggestion was successfully created.') }
        format.xml  { render :xml => @suggestion, :status => :created, :location => @suggestion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @suggestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /suggestions/1
  # PUT /suggestions/1.xml
  def update
    respond_to do |format|
      if @suggestion.update_attributes(params[:suggestion])
        format.html { redirect_to(@suggestion, :notice => 'Suggestion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @suggestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.xml
  def destroy
    @suggestion.destroy

    respond_to do |format|
      format.html { redirect_to(suggestions_url) }
      format.xml  { head :ok }
    end
  end
end
