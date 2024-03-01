class CollectionLogsController < ApplicationController
  before_action :set_collection_log, only: %i[show edit update destroy]

  # GET /collection_logs or /collection_logs.json
  def index
    @collection_logs = CollectionLog.all
  end

  # GET /collection_logs/1 or /collection_logs/1.json
  def show; end

  # GET /collection_logs/new
  def new
    @collection_log = CollectionLog.new
  end

  # GET /collection_logs/1/edit
  def edit; end

  # POST /collection_logs or /collection_logs.json
  def create
    @collection_log = CollectionLog.new(collection_log_params)

    respond_to do |format|
      if @collection_log.save
        format.html do
          redirect_to collection_log_url(@collection_log), notice: 'Collection log was successfully created.'
        end
        format.json { render :show, status: :created, location: @collection_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collection_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collection_logs/1 or /collection_logs/1.json
  def update
    respond_to do |format|
      if @collection_log.update(collection_log_params)
        format.html do
          redirect_to collection_log_url(@collection_log), notice: 'Collection log was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @collection_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collection_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collection_logs/1 or /collection_logs/1.json
  def destroy
    @collection_log.destroy!

    respond_to do |format|
      format.html { redirect_to collection_logs_url, notice: 'Collection log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_collection_log
    @collection_log = CollectionLog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def collection_log_params
    params.fetch(:collection_log, {})
  end
end
