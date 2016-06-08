require 'test_helper'

class ActivitiesMetricsControllerTest < ActionController::TestCase
  setup do
    @activities_metric = activities_metrics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activities_metrics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create activities_metric" do
    assert_difference('ActivitiesMetric.count') do
      post :create, activities_metric: { activity: @activities_metric.activity, conversion: @activities_metric.conversion, leads: @activities_metric.leads, max_time_client: @activities_metric.max_time_client, relevant_leads: @activities_metric.relevant_leads, time_spent: @activities_metric.time_spent, week: @activities_metric.week }
    end

    assert_redirected_to activities_metric_path(assigns(:activities_metric))
  end

  test "should show activities_metric" do
    get :show, id: @activities_metric
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @activities_metric
    assert_response :success
  end

  test "should update activities_metric" do
    patch :update, id: @activities_metric, activities_metric: { activity: @activities_metric.activity, conversion: @activities_metric.conversion, leads: @activities_metric.leads, max_time_client: @activities_metric.max_time_client, relevant_leads: @activities_metric.relevant_leads, time_spent: @activities_metric.time_spent, week: @activities_metric.week }
    assert_redirected_to activities_metric_path(assigns(:activities_metric))
  end

  test "should destroy activities_metric" do
    assert_difference('ActivitiesMetric.count', -1) do
      delete :destroy, id: @activities_metric
    end

    assert_redirected_to activities_metrics_path
  end
end
