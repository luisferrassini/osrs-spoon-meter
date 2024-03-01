class CollectionLogEntriesController < ApplicationController
  before_action :set_collection_log_entry, only: %i[ show edit update destroy ]

  # GET /collection_log_entries or /collection_log_entries.json
  def index
    @collection_log_entries = CollectionLogEntry.all
  end

  # GET /collection_log_entries/1 or /collection_log_entries/1.json
  def show
  end

  # GET /collection_log_entries/new
  def new
    @collection_log_entry = CollectionLogEntry.new
  end

  # GET /collection_log_entries/1/edit
  def edit
  end

  # POST /collection_log_entries or /collection_log_entries.json
  def create
    @collection_log_entry = CollectionLogEntry.new(collection_log_entry_params)

    respond_to do |format|
      if @collection_log_entry.save
        format.html { redirect_to collection_log_entry_url(@collection_log_entry), notice: "Collection log entry was successfully created." }
        format.json { render :show, status: :created, location: @collection_log_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collection_log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collection_log_entries/1 or /collection_log_entries/1.json
  def update
    respond_to do |format|
      if @collection_log_entry.update(collection_log_entry_params)
        format.html { redirect_to collection_log_entry_url(@collection_log_entry), notice: "Collection log entry was successfully updated." }
        format.json { render :show, status: :ok, location: @collection_log_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collection_log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collection_log_entries/1 or /collection_log_entries/1.json
  def destroy
    @collection_log_entry.destroy!

    respond_to do |format|
      format.html { redirect_to collection_log_entries_url, notice: "Collection log entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection_log_entry
      @collection_log_entry = CollectionLogEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def collection_log_entry_params
      params.fetch(:collection_log_entry, {})
    end
end
