class CollectionLogItemsController < ApplicationController
  before_action :set_collection_log_item, only: %i[ show edit update destroy ]

  # GET /collection_log_items or /collection_log_items.json
  def index
    @collection_log_items = CollectionLogItem.all
  end

  # GET /collection_log_items/1 or /collection_log_items/1.json
  def show
  end

  # GET /collection_log_items/new
  def new
    @collection_log_item = CollectionLogItem.new
  end

  # GET /collection_log_items/1/edit
  def edit
  end

  # POST /collection_log_items or /collection_log_items.json
  def create
    @collection_log_item = CollectionLogItem.new(collection_log_item_params)

    respond_to do |format|
      if @collection_log_item.save
        format.html { redirect_to collection_log_item_url(@collection_log_item), notice: "Collection log item was successfully created." }
        format.json { render :show, status: :created, location: @collection_log_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collection_log_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collection_log_items/1 or /collection_log_items/1.json
  def update
    respond_to do |format|
      if @collection_log_item.update(collection_log_item_params)
        format.html { redirect_to collection_log_item_url(@collection_log_item), notice: "Collection log item was successfully updated." }
        format.json { render :show, status: :ok, location: @collection_log_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collection_log_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collection_log_items/1 or /collection_log_items/1.json
  def destroy
    @collection_log_item.destroy!

    respond_to do |format|
      format.html { redirect_to collection_log_items_url, notice: "Collection log item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection_log_item
      @collection_log_item = CollectionLogItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def collection_log_item_params
      params.fetch(:collection_log_item, {})
    end
end
