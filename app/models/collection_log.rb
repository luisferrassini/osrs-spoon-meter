# app/models/collection_log.rb
class CollectionLog < ApplicationRecord
  belongs_to :player
  has_many :tabs, dependent: :destroy

  accepts_nested_attributes_for :tabs

  def self.create_from_api_data(player_name)
    response = HTTParty.get("https://api.collectionlog.net/collectionlog/user/#{player_name}")
    return unless response.code == 200

    data = response.parsed_response
    log_data = data['collectionLog']
    log = CollectionLog.create(
      user_id: log_data['userId'],
      collection_log_id: log_data['collectionLogId']
    )

    log.create_tabs(log_data['tabs']) if log.persisted?

    log
  end

  private

  def create_tabs(tabs_data)
    tabs_data.each do |tab_name, collection_log_entries|
      tab = tabs.create(name: tab_name)
      create_collection_log_entries(tab, collection_log_entries) if tab.persisted?
    end
  end

  def create_collection_log_entries(tab, collection_log_entries_data)
    collection_log_entries_data.each do |collection_log_entry_name, collection_log_entry_data|
      collection_log_items = collection_log_entry_data['items'].map do |item_data|
        tab.collection_log_items.create(
          item_id: item_data['id'],
          name: item_data['name'],
          quantity: item_data['quantity'],
          obtained: item_data['obtained'],
          obtained_at: item_data['obtainedAt'],
          sequence: item_data['sequence']
        )
      end

      kill_counts = collection_log_entry_data['killCount']&.map do |kill_count_data|
        tab.kill_counts.create(
          name: kill_count_data['name'],
          amount: kill_count_data['amount'],
          sequence: kill_count_data['sequence']
        )
      end
      if kill_counts.nil?
        tab.collection_log_entries.create(collection_log_items:, name: collection_log_entry_name)
      else
        tab.collection_log_entries.create(collection_log_items:, kill_counts:, name: collection_log_entry_name)
      end
    end
  end
end
