require 'test_helper'

class DeohtestsControllerTest < ActionController::TestCase
  setup do
    @deohtest = deohtests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deohtests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deohtest" do
    assert_difference('Deohtest.count') do
      post :create, deohtest: {  }
    end

    assert_redirected_to deohtest_path(assigns(:deohtest))
  end

  test "should show deohtest" do
    get :show, id: @deohtest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deohtest
    assert_response :success
  end

  test "should update deohtest" do
    put :update, id: @deohtest, deohtest: {  }
    assert_redirected_to deohtest_path(assigns(:deohtest))
  end

  test "should destroy deohtest" do
    assert_difference('Deohtest.count', -1) do
      delete :destroy, id: @deohtest
    end

    assert_redirected_to deohtests_path
  end
end
