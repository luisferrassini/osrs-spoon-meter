class GameItemsController < ApplicationController
  before_action :set_game_item, only: %i[show edit update destroy]

  # GET /game_items
  def index
    @game_items = GameItem.all
  end

  # GET /game_items/1
  def show; end

  # GET /game_items/new
  def new
    @game_item = GameItem.new
  end

  # GET /game_items/1/edit
  def edit; end

  # POST /game_items
  def create
    @game_item = GameItem.new(game_item_params)

    if @game_item.save
      redirect_to @game_item, notice: 'Game Item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /game_items/1
  def update
    if @game_item.update(game_item_params)
      redirect_to @game_item, notice: 'Game Item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /game_items/1
  def destroy
    @game_item.destroy
    redirect_to game_items_url, notice: 'Game Item was successfully destroyed.'
  end

  def fetch_drop_rate
    @game_item = GameItem.find_by(id: params[:id])

    if @game_item.nil?
      render json: { error: 'Game item not found' }, status: :not_found
      return
    end

    drop_rate_fetcher = DropRateFetcher.new(DropRateWikiStrategy.new)
    drop_rate = fetch_drop_rate_for_game_item(drop_rate_fetcher, @game_item)

    render json: drop_rate
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game_item
    @game_item = GameItem.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def game_item_params
    params.require(:game_item).permit(:name, :last_updated, :incomplete, :members, :tradeable, :tradeable_on_ge,
                                      :stackable, :stacked, :noted, :noteable, :linked_id_item, :linked_id_noted, :linked_id_placeholder, :placeholder, :equipable, :equipable_by_player, :equipable_weapon, :cost, :lowalch, :highalch, :weight, :buy_limit, :quest_item, :release_date, :duplicate, :examine, :icon, :wiki_name, :wiki_url, :equipment, :weapon)
  end

  def fetch_drop_rate_for_game_item(drop_rate_fetcher, game_item)
    return unless game_item.name || game_item.item_id

    if game_item.name
      drop_rate_fetcher.fetch_drop_rate(name: game_item.name)
    else
      drop_rate_fetcher.fetch_drop_rate(game_item_id: game_item.item_id)
    end
  end
end
