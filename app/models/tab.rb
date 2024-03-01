# app/models/tab.rb
class Tab < ApplicationRecord
  belongs_to :collection_log
  has_many :collection_log_entries, dependent: :destroy
  has_many :collection_log_items, through: :collection_log_entries
  has_many :kill_counts, through: :collection_log_entries

  validates :name, presence: true

  accepts_nested_attributes_for :collection_log_entries

  def self.create_from_api_data(tab_name, collection_log_entries_data)
    tab = Tab.create(name: tab_name)
    tab.create_collection_log_entries(collection_log_entries_data) if tab.persisted?
    tab
  end

  private

  def create_collection_log_entries(collection_log_entries_data)
    collection_log_entries_data.each do |collection_log_entry_name, collection_log_entry_data|
      collection_log_items = collection_log_entry_data['items'].map do |item_data|
        CollectionLogItems.create(
          id: item_data['id'],
          name: item_data['name'],
          quantity: item_data['quantity'],
          obtained: item_data['obtained'],
          obtained_at: item_data['obtainedAt'],
          sequence: item_data['sequence']
        )
      end

      kill_count = collection_log_entry_data['killCount']&.map do |kill_count_data|
        KillCounts.create(
          name: kill_count_data['name'],
          amount: kill_count_data['amount'],
          sequence: kill_count_data['sequence']
        )
      end

      collection_log_entries.create(collection_log_items:, kill_count:, name: collection_log_entry_name)
    end
  end
end
