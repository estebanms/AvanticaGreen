require 'test_helper'

class InfractionTypesControllerTest < ActionController::TestCase
  setup do
    @infraction_type = infraction_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:infraction_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create infraction_type" do
    assert_difference('InfractionType.count') do
      post :create, :infraction_type => @infraction_type.attributes
    end

    assert_redirected_to infraction_type_path(assigns(:infraction_type))
  end

  test "should show infraction_type" do
    get :show, :id => @infraction_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @infraction_type.to_param
    assert_response :success
  end

  test "should update infraction_type" do
    put :update, :id => @infraction_type.to_param, :infraction_type => @infraction_type.attributes
    assert_redirected_to infraction_type_path(assigns(:infraction_type))
  end

  test "should destroy infraction_type" do
    assert_difference('InfractionType.count', -1) do
      delete :destroy, :id => @infraction_type.to_param
    end

    assert_redirected_to infraction_types_path
  end
end
