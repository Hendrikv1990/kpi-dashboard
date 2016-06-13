require 'test_helper'

class MetricsTargetsControllerTest < ActionController::TestCase
  setup do
    @metrics_target = metrics_targets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metrics_targets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metrics_target" do
    assert_difference('MetricsTarget.count') do
      post :create, metrics_target: { conversion: @metrics_target.conversion, leads: @metrics_target.leads, max_time_client: @metrics_target.max_time_client, relevant_leads: @metrics_target.relevant_leads, time_spent: @metrics_target.time_spent }
    end

    assert_redirected_to metrics_target_path(assigns(:metrics_target))
  end

  test "should show metrics_target" do
    get :show, id: @metrics_target
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @metrics_target
    assert_response :success
  end

  test "should update metrics_target" do
    patch :update, id: @metrics_target, metrics_target: { conversion: @metrics_target.conversion, leads: @metrics_target.leads, max_time_client: @metrics_target.max_time_client, relevant_leads: @metrics_target.relevant_leads, time_spent: @metrics_target.time_spent }
    assert_redirected_to metrics_target_path(assigns(:metrics_target))
  end

  test "should destroy metrics_target" do
    assert_difference('MetricsTarget.count', -1) do
      delete :destroy, id: @metrics_target
    end

    assert_redirected_to metrics_targets_path
  end
end
