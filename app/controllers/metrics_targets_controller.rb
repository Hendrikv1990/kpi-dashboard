class MetricsTargetsController < ApplicationController
  before_action :set_metrics_target, only: [:show, :edit, :update, :destroy]

  # GET /metrics_targets
  # GET /metrics_targets.json
  def index
    @metrics_targets = MetricsTarget.all
    File.open('metrics_targets.json', 'w') { |file| file.write(@metrics_targets.to_json) }
  end

  # GET /metrics_targets/1
  # GET /metrics_targets/1.json
  def show
  end

  # GET /metrics_targets/new
  def new
    @metrics_target = MetricsTarget.new
  end

  # GET /metrics_targets/1/edit
  def edit
  end

  # POST /metrics_targets
  # POST /metrics_targets.json
  def create
    @metrics_target = MetricsTarget.new(metrics_target_params)

    respond_to do |format|
      if @metrics_target.save
        format.html { redirect_to @metrics_target, notice: 'Metrics target was successfully created.' }
        format.json { render :show, status: :created, location: @metrics_target }
      else
        format.html { render :new }
        format.json { render json: @metrics_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metrics_targets/1
  # PATCH/PUT /metrics_targets/1.json
  def update
    respond_to do |format|
      if @metrics_target.update(metrics_target_params)
        format.html { redirect_to @metrics_target, notice: 'Metrics target was successfully updated.' }
        format.json { render :show, status: :ok, location: @metrics_target }
      else
        format.html { render :edit }
        format.json { render json: @metrics_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metrics_targets/1
  # DELETE /metrics_targets/1.json
  def destroy
    @metrics_target.destroy
    respond_to do |format|
      format.html { redirect_to metrics_targets_url, notice: 'Metrics target was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metrics_target
      @metrics_target = MetricsTarget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metrics_target_params
      params.require(:metrics_target).permit(:leads, :relevant_leads, :conversion, :time_spent, :max_time_client)
    end
end
