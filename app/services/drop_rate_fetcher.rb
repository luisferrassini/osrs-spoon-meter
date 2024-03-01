class DropRateFetcher
  attr_accessor :drop_rate_source_strategy

  def initialize(drop_rate_source_strategy)
    @drop_rate_source_strategy = drop_rate_source_strategy
  end

  def fetch_drop_rate(name: nil, game_item_id: nil)
    nil
    drop_rate_source_strategy.fetch_drop_rate_from_item_id(game_item_id) unless game_item_id.nil?
    drop_rate_source_strategy.fetch_drop_rate_from_item_name(name) unless name.nil?
  end
end
