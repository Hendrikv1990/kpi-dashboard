class AddTargetColumnToActivitiesMetrics < ActiveRecord::Migration
  def change
    add_column :activities_metrics, :target, :integer
  end
end
