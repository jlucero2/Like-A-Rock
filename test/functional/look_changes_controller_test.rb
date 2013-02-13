require 'test_helper'

class LookChangesControllerTest < ActionController::TestCase
  setup do
    @look_change = look_changes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:look_changes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create look_change" do
    assert_difference('LookChange.count') do
      post :create, look_change: {  }
    end

    assert_redirected_to look_change_path(assigns(:look_change))
  end

  test "should show look_change" do
    get :show, id: @look_change
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @look_change
    assert_response :success
  end

  test "should update look_change" do
    put :update, id: @look_change, look_change: {  }
    assert_redirected_to look_change_path(assigns(:look_change))
  end

  test "should destroy look_change" do
    assert_difference('LookChange.count', -1) do
      delete :destroy, id: @look_change
    end

    assert_redirected_to look_changes_path
  end
end
