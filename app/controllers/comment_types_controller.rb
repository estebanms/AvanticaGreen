class CommentTypesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => :create
  before_filter :permitted_params, :only => [:new, :edit]

  # GET /comment_types
  # GET /comment_types.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comment_types }
    end
  end

  # GET /comment_types/1
  # GET /comment_types/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment_type }
    end
  end

  # GET /comment_types/new
  # GET /comment_types/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment_type }
    end
  end

  # GET /comment_types/1/edit
  def edit
  end

  # POST /comment_types
  # POST /comment_types.xml
  def create
    @comment_type = CommentType.new(comment_type_params)
    respond_to do |format|
      if @comment_type.save
        format.html { redirect_to(@comment_type, :notice => 'Comment type was successfully created.') }
        format.xml  { render :xml => @comment_type, :status => :created, :location => @comment_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comment_types/1
  # PUT /comment_types/1.xml
  def update
    respond_to do |format|
      if @comment_type.update_attributes(comment_type_params)
        format.html { redirect_to(@comment_type, :notice => 'Comment type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_types/1
  # DELETE /comment_types/1.xml
  def destroy
    @comment_type.destroy

    respond_to do |format|
      format.html { redirect_to(comment_types_url) }
      format.xml  { head :ok }
    end
  end

  private

  def permitted_params
    @permitted_params ||= [:name, :description]
  end

  def comment_type_params
    params.require(:comment_type).permit(*permitted_params)
  end
end
