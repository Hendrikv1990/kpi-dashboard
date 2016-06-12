#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'pp'

$metrics = ["leads","relevant_leads","conversion","time_spent","max_time_client"]  
$current_week = 1 #max among all weeks in json
$previous_week = $current_week - 1

def init()
$activities = [] # activities available in json
$data = {} # metrics for each activity
$metricsTotal = Hash.new({}) # metrics summary for each week
$diagramInput = Hash.new({}) #metrics per each activity in the format required for diagrams build up
end

def readJson(file)
   json = File.read(file)
   dataHash = JSON.parse(json)
   return dataHash
end

def get_latest_week(dataHash)
  return dataHash.map{|row| row["week"]}.max
end

def get_activities_names(dataHash)
   activities = dataHash.map{|row| row["activity"]}.uniq
   return activities
end

# get metrics names is not used now, insteda defined implicitly as an array
def get_metrics_names(dataHash)
   metrics_names = dataHash.first.keys
   return metrics_names
end


def calcMetricsSummary(dataHash)
  total = {}
  $metricsTotal = dataHash.group_by{|item| item["week"]}.inject({}){|total, (k,v)| 
    total[k] = Hash.new({})
    $metrics.each do |metric_name|
      total[k][metric_name] = {label: metric_name, value: 0}
      total[k][metric_name][:value] = v.inject(0){|acc, item| acc+item[metric_name]}
    end
    total
  }
end

#for building diagram activity metrics per time
def getAllActivityMetrics(dataHash, activity_name)
    $data[activity_name] = dataHash.select do |row|
      row["activity"].eql? activity_name 
    end
end

def formWidgetsInputData(activity_name, metric_name)
    metricData = {x: 0, y: 0}
    $data[activity_name].each{ |row|
      if $diagramInput[activity_name][metric_name] == nil then
        $diagramInput[activity_name][metric_name] = []
      end
      metricData = {x: row["week"], y: row[metric_name]} 
      $diagramInput[activity_name][metric_name].push(metricData)
    }
end

def updateWidgetCurrentVsPrevious(activity_name, metric_name)
  last_item = $diagramInput[activity_name][metric_name].select{|item| item[:x] == $previous_week}
  current_item = $diagramInput[activity_name][metric_name].select{|item| item[:x] == $current_week}
  print activity_name
  print metric_name
  $last = 0 
  $current = 0
  $last = last_item[0][:y] unless (last_item.length == 0)
  $current = current_item[0][:y] unless (current_item.length == 0)
  print $last
  print $current
      
  Dashing.send_event(activity_name+" "+metric_name, { current: $current, last: $last })
end       

def updateWidgetActivityGraph(activity_name, metric_name)
  Dashing.send_event(activity_name+" "+metric_name + " Graph", points: $diagramInput[activity_name][metric_name])
end

def updateActivityWidgets(activity_name)
  # Activity widgets: 
     $metrics.each do |metric_name|
       formWidgetsInputData(activity_name, metric_name)
       # show widget Current Week vs Previous
       updateWidgetCurrentVsPrevious(activity_name, metric_name)
       updateWidgetActivityGraph(activity_name, metric_name)
    end  
end 



Dashing.scheduler.every '60s' do
  init()
  rows = readJson('activities_metrics.json')
  $activities = get_activities_names(rows)
  $current_week = get_latest_week(rows) #max among all weeks in json
  $previous_week = $current_week - 1
  $activities.each do |activity_name|
     getAllActivityMetrics(rows, activity_name)
     updateActivityWidgets(activity_name)
  end  
  # kpiSummary per week
  calcMetricsSummary(rows)
  print $metricsTotal[$current_week].values
  Dashing.send_event("Metrics Total", { items: $metricsTotal[$current_week].values })
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