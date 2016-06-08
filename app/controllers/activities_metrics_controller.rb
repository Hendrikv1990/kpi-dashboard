class ActivitiesMetricsController < ApplicationController
  before_action :set_activities_metric, only: [:show, :edit, :update, :destroy]

  # GET /activities_metrics
  # GET /activities_metrics.json
  def index
    @activities_metrics = ActivitiesMetric.all
    File.open('activities_metrics.json', 'w') { |file| file.write(@activities_metrics.to_json) }
  end

  # GET /activities_metrics/1
  # GET /activities_metrics/1.json
  def show
  end

  # GET /activities_metrics/new
  def new
    @activities_metric = ActivitiesMetric.new
  end

  # GET /activities_metrics/1/edit
  def edit
  end

  # POST /activities_metrics
  # POST /activities_metrics.json
  def create
    @activities_metric = ActivitiesMetric.new(activities_metric_params)

    respond_to do |format|
      if @activities_metric.save
        format.html { redirect_to @activities_metric, notice: 'Activities metric was successfully created.' }
        format.json { render :show, status: :created, location: @activities_metric }
      else
        format.html { render :new }
        format.json { render json: @activities_metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities_metrics/1
  # PATCH/PUT /activities_metrics/1.json
  def update
    respond_to do |format|
      if @activities_metric.update(activities_metric_params)
        format.html { redirect_to @activities_metric, notice: 'Activities metric was successfully updated.' }
        format.json { render :show, status: :ok, location: @activities_metric }
      else
        format.html { render :edit }
        format.json { render json: @activities_metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities_metrics/1
  # DELETE /activities_metrics/1.json
  def destroy
    @activities_metric.destroy
    respond_to do |format|
      format.html { redirect_to activities_metrics_url, notice: 'Activities metric was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activities_metric
      @activities_metric = ActivitiesMetric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activities_metric_params
      params.require(:activities_metric).permit(:activity, :week, :leads, :relevant_leads, :conversion, :time_spent, :max_time_client)
    end
end
