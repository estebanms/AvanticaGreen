class CommentsController < ApplicationController
  include CommentsHelper
  before_filter :get_commentable
  load_and_authorize_resource
  skip_load_resource :only => [:index, :new, :create]
  before_filter :permitted_params, :only => [:new, :edit]

  # GET /comments
  # GET /comments.xml
  def index
    @comments = @commentable.comments

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.js #show.js.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    @comment.commentable = @commentable

    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(comment_params)
    @comment.player = current_player

    if @commentable
      # WARNING: there is a bug in Rails that stores @commentable.class.base_class
      # instead of @commentable.class in the commentable_type field.
      # You can see more details here: https://github.com/rails/rails/issues/617
      # For example, if @commentable is an instance of Suggestion, 
      # then commentable_type will have 'Post', not 'Suggestion'.
      # This will work for now because Suggestion is the only commentable class
      # that inherits from Post. However, if we ever had another commentable class
      # that inherits from Post, then we would have to manually assign the 
      # commentable_type and commentable_id columns.
      # The same applies for the new action of this controller.
      @comment.commentable = @commentable
      @comments_size = Comment.where(:commentable_id => @commentable).count
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@comment, :notice => 'Comment was successfully created.') }
        format.js
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => 'new' }
        format.js   { render :action => 'errors' }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.js   { render :action => 'show' }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit' }
        format.js   { render :action => 'errors' }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    begin
      @comment.destroy
    rescue ActiveRecord::DeleteRestrictionError => exception
      @comment.errors.add(:commentable, exception.message)
    end

    @comments_size = Comment.count(:conditions => "commentable_id = #{@commentable.id}")
    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.js   { render :action => @comment.errors.any? ? 'errors' : 'destroy' }
      format.xml  { head :ok }
    end
  end

private
  def get_commentable
    # include all possible commentable classes here
    commentable_classes = [Infraction, Suggestion]
    commentable_classes.each do |commentable_class|
      id_column = "#{commentable_class.to_s.underscore}_id".to_sym
      @commentable = commentable_class.find(params[id_column]) if params[id_column]
      break if @commentable
    end
  end

  def permitted_params
    @permitted_params ||= [:description, :post_type_id, :anonymous]
  end

  def comment_params
    params.require(:comment).permit(*permitted_params)
  end
end
