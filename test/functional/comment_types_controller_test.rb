require 'test_helper'

class CommentTypesControllerTest < ActionController::TestCase
  setup do
    @comment_type = comment_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comment_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comment_type" do
    assert_difference('CommentType.count') do
      post :create, :comment_type => @comment_type.attributes
    end

    assert_redirected_to comment_type_path(assigns(:comment_type))
  end

  test "should show comment_type" do
    get :show, :id => @comment_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @comment_type.to_param
    assert_response :success
  end

  test "should update comment_type" do
    put :update, :id => @comment_type.to_param, :comment_type => @comment_type.attributes
    assert_redirected_to comment_type_path(assigns(:comment_type))
  end

  test "should destroy comment_type" do
    assert_difference('CommentType.count', -1) do
      delete :destroy, :id => @comment_type.to_param
    end

    assert_redirected_to comment_types_path
  end
end
