class CollectionLogEntry < ApplicationRecord
  belongs_to :tab
  has_many :collection_log_items, dependent: :destroy
  has_many :kill_counts, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :collection_log_items, :kill_counts

  def self.create_from_api_data(tab, collection_log_entry_name, collection_log_entry_data)
    collection_log_entry = tab.collection_log_entries.create(name: collection_log_entry_name)
    collection_log_entry.create_items_and_kill_counts(collection_log_entry_data) if collection_log_entry.persisted?
    collection_log_entry
  end

  private

  def create_items_and_kill_counts(collection_log_entry_data)
    collection_log_entry_data['items'].each do |item_data|
      collection_log_items.create(
        item_id: item_data['id'],
        name: item_data['name'],
        quantity: item_data['quantity'],
        obtained: item_data['obtained'],
        obtained_at: item_data['obtainedAt'],
        sequence: item_data['sequence']
      )
    end

    collection_log_entry_data['killCount']&.each do |kill_count_data|
      kill_counts.create(
        name: kill_count_data['name'],
        amount: kill_count_data['amount'],
        sequence: kill_count_data['sequence']
      )
    end
  end
end
