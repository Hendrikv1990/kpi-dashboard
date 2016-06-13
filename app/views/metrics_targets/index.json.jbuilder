json.array!(@metrics_targets) do |metrics_target|
  json.extract! metrics_target, :id, :leads, :relevant_leads, :conversion, :time_spent, :max_time_client
  json.url metrics_target_url(metrics_target, format: :json)
end
