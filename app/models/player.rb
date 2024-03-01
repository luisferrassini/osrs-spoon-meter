class Player < ApplicationRecord
  has_one :collection_log

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  after_create :fetch_collection_log

  def delete_collection_log
    collection_log&.destroy
  end

  def fetch_collection_log
    response = HTTParty.get("https://api.collectionlog.net/collectionlog/user/#{CGI.escape(name)}")
    if response.code == 200
      puts "Successfully fetched collection log for #{name}"
      delete_collection_log
      create_collection_log(response.parsed_response)
    else
      puts "Failed to fetch collection log for #{name}: #{response}"
    end
  end

  private

  def create_collection_log(data)
    tabs = data.dig('collectionLog', 'tabs').to_h.map do |tab_name, collection_log_entries|
      collection_log_entries_data = collection_log_entries.map do |collection_log_entry_name, collection_log_entry_data|
        collection_log_items = collection_log_entry_data['items'].map do |item_data|
          CollectionLogItem.new(
            item_id: item_data['id'],
            name: item_data['name'],
            quantity: item_data['quantity'],
            obtained: item_data['obtained'],
            obtained_at: item_data['obtainedAt'],
            sequence: item_data['sequence']
          )
        end

        kill_counts = collection_log_entry_data['killCount']&.map do |kill_count_data|
          KillCount.new(
            name: kill_count_data['name'],
            amount: kill_count_data['amount'],
            sequence: kill_count_data['sequence']
          )
        end

        if kill_counts.nil?
          CollectionLogEntry.new(collection_log_items:, name: collection_log_entry_name)
        else
          CollectionLogEntry.new(collection_log_items:, kill_counts:, name: collection_log_entry_name)
        end
      end

      Tab.new(collection_log_entries: collection_log_entries_data, name: tab_name)
    end

    collection_log = CollectionLog.new(tabs:)
    self.collection_log = collection_log
  end
end
