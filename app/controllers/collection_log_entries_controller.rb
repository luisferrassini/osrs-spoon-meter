class CollectionLogEntriesController < ApplicationController
  include WikiDryCalculatorHelper
  before_action :set_collection_log_entry, only: %i[show edit update destroy]

  # GET /collection_log_entries or /collection_log_entries.json
  def index
    @collection_log_entries = CollectionLogEntry.all
  end

  # GET /collection_log_entries/1 or /collection_log_entries/1.json
  def show
    @collection_log_entry_with_drop_rates = @collection_log_entry.collection_log_items.map do |collection_log_item|
      drop_rates = fetch_drop_rate(collection_log_item.name)
      { collection_log_item:, drop_rate: drop_rates.each do |x|
                                           x[:Dryness] = dry_calculator(
                                             x[:Rarity2],
                                             collection_log_item.collection_log_entry.kill_counts&.first&.amount,
                                             x[:Quantity].to_i == 0 ? 1 : (collection_log_item.quantity.to_i / x[:Quantity].to_i)
                                           )[0]
                                         end }
    end
  end

  # GET /collection_log_entries/new
  def new
    @collection_log_entry = CollectionLogEntry.new
  end

  # GET /collection_log_entries/1/edit
  def edit; end

  # POST /collection_log_entries or /collection_log_entries.json
  def create
    @collection_log_entry = CollectionLogEntry.new(collection_log_entry_params)

    respond_to do |format|
      if @collection_log_entry.save
        format.html do
          redirect_to collection_log_entry_url(@collection_log_entry),
                      notice: 'Collection log entry was successfully created.'
        end
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
        format.html do
          redirect_to collection_log_entry_url(@collection_log_entry),
                      notice: 'Collection log entry was successfully updated.'
        end
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
      format.html { redirect_to collection_log_entries_url, notice: 'Collection log entry was successfully destroyed.' }
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

  def fetch_drop_rate(item_name)
    drop_rate_fetcher = DropRateFetcher.new(DropRateWikiStrategy.new)
    fetch_drop_rate_for_game_item(drop_rate_fetcher, item_name)
  end

  def fetch_drop_rate_for_game_item(drop_rate_fetcher, item_name)
    # return unless game_item.name || game_item.item_id
    return unless item_name

    # if game_item.name
    #   drop_rate_fetcher.fetch_drop_rate(name: game_item.name)
    # else
    drop_rate_fetcher.fetch_drop_rate(name: item_name)
    # end
  end
end
