class CreateActivitiesMetrics < ActiveRecord::Migration
  def change
    create_table :activities_metrics do |t|
      t.string :activity
      t.integer :week
      t.integer :leads
      t.integer :relevant_leads
      t.integer :conversion
      t.integer :time_spent
      t.integer :max_time_client

      t.timestamps null: false
    end
  end
end
