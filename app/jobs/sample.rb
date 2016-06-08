#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'pp'

$current = 0
$current_week = 2
$previous_week = $current_week - 1
$activities = []
$data = {} # metrics for each activity
$metricsTotal = Hash.new({ value: 0 }) # metrics summary
$metrics = ["leads","relevant_leads","conversion","time_spent","max_time_client"]
$actualData = {} # metrics per activity for this and previous weeks only

def readJson(file)
   json = File.read(file)
   dataHash = JSON.parse(json)
   return dataHash
end

def find_activities(dataHash)
   activities = dataHash.map{|row| row["activity"]}.uniq
   return activities
end

def get_metrics_names(dataHash)
   metrics_names = dataHash.first.keys
   return metrics_names
end

def getAllActivityMetrics(dataHash, activity_name)
    $data[activity_name] = dataHash.select do |row|
      row["activity"].eql? activity_name 
    end
end

def getActivityMetricsActual(activity_name)
    actual = $data[activity_name].select do |row|
        row["week"] == $current_week || row["week"] == $previous_week 
    end
    return actual      
end

def calcMetricsSummary(dataHash)
	$metrics.each do |metric_name|
		$metricsTotal[metric_name] = {label: metric_name, value: 0}
        dataHash.each{|row| 
        	week = row["week"].to_s
        	# for each week?
        	if (row["week"] == $current_week) then
        	#if week not in $metricsTotal[metric_name] then 
        	#	metricsTotal[metric_name][week] 
        	#    $metricsTotal[metric_name][week] += row[metric_name]
        	#    print "Metric per week"
        	#    print $metricsTotal[metric_name][week]
        	#    print "\n"
        		$metricsTotal[metric_name][:value] += row[metric_name]
        	end
        } 
    end   
end

Dashing.scheduler.every '60s' do
  rows = readJson('activities_metrics.json')
  $activities = find_activities(rows)
  print "Activities \n"
  print $activities
  # Per Activity metrics: 
  $activities.each do |activity_name|
  	 # data to view metrics per time
  	 getAllActivityMetrics(rows, activity_name)   
  	 # for each metric: $data[activity_name][0].keys.each do |metric_name|
  	 # Dashing.send_event('activity #{activity_name}', { current: $current, last: $last })
  	 # data to view difference between current and previous weeks
  	 $actualData[activity_name] = getActivityMetricsActual(activity_name)

  	 $last = 1
  	 $current = $actualData[activity_name][0]["leads"]
  	 if $actualData[activity_name].length != 1 then
  	     $last = $actualData[activity_name][1]["leads"]
  	 end 
  	 Dashing.send_event(activity_name, { current: $current, last: $last })
  	 # activity current week value against target value:
  	 # Dashing.send_event('activity #{activity_name}', { current: $current, last: $last })
  end
  # kpiSummary per week
  calcMetricsSummary(rows)
  print $metricsTotal.values
  Dashing.send_event("Metrics Total", { items: $metricsTotal.values })
  # data
 # print "Data:"
 # print $data 
 # print "\n"
 # print "Actual Data:"
 # print $actualData 
 # print "\n"
 # print "MetricsTotal"
 # print $metricsTotal 
#  print "\n"
  # add graph for leads KPI
  #$metricsTotal["leads"]
  #points << { x: i, y: rand(50) }


end