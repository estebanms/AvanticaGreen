require 'test_helper'

class SuggestionTypesControllerTest < ActionController::TestCase
  setup do
    @suggestion_type = suggestion_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:suggestion_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create suggestion_type" do
    assert_difference('SuggestionType.count') do
      post :create, :suggestion_type => @suggestion_type.attributes
    end

    assert_redirected_to suggestion_type_path(assigns(:suggestion_type))
  end

  test "should show suggestion_type" do
    get :show, :id => @suggestion_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @suggestion_type.to_param
    assert_response :success
  end

  test "should update suggestion_type" do
    put :update, :id => @suggestion_type.to_param, :suggestion_type => @suggestion_type.attributes
    assert_redirected_to suggestion_type_path(assigns(:suggestion_type))
  end

  test "should destroy suggestion_type" do
    assert_difference('SuggestionType.count', -1) do
      delete :destroy, :id => @suggestion_type.to_param
    end

    assert_redirected_to suggestion_types_path
  end
end
