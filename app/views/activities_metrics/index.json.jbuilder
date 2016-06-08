json.array!(@activities_metrics) do |activities_metric|
  json.extract! activities_metric, :id, :activity, :week, :leads, :relevant_leads, :conversion, :time_spent, :max_time_client
  json.url activities_metric_url(activities_metric, format: :json)
end
