class SuggestionTypesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => :create
  before_filter :permitted_params, :only => [:new, :edit]

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
    @suggestion_type = SuggestionType.new(suggestion_type_params)
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
      if @suggestion_type.update_attributes(suggestion_type_params)
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

  private

  def permitted_params
    @permitted_params ||= [:name, :description]
  end

  def suggestion_type_params
    params.require(:suggestion_type).permit(*permitted_params)
  end
end
