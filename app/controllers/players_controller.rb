# app/controllers/players_controller.rb
class PlayersController < ApplicationController
  before_action :set_player, only: %i[show edit update destroy]

  # GET /players
  def index
    @players = Player.all
  end

  # GET /players/1
  def show; end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit; end

  # POST /players
  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
    redirect_to players_url, notice: 'Player was successfully destroyed.'
  end

  def fetch_collection_log
    @player = Player.find(params[:id])
    if Time.now - @player.collection_log.updated_at < 2.minutes
      redirect_to @player, alert: 'You can only fetch every 2 minutes.'
    else
      @player.fetch_collection_log
      redirect_to @player, notice: 'Collection log fetched successfully.'
    end
  rescue StandardError => e
    redirect_to @player, alert: "Failed to fetch collection log: #{e.message}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def player_params
    params.require(:player).permit(:name)
  end
end
