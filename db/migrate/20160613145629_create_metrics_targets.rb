class CreateMetricsTargets < ActiveRecord::Migration
  def change
    create_table :metrics_targets do |t|
      t.integer :leads
      t.integer :relevant_leads
      t.integer :conversion
      t.integer :time_spent
      t.integer :max_time_client

      t.timestamps null: false
    end
  end
end
