# app/models/collection_log_item.rb
class CollectionLogItem < ApplicationRecord
  belongs_to :collection_log_entry

  validates :name, presence: true
  validates :quantity, presence: true
  validates :item_id, presence: true
  # validates :obtained, inclusion: { in: [true, false] }
  # validates :obtained_at, presence: true
  # validates :sequence, presence: true

  def to_s
    "#{name} (#{item_id}): #{quantity} (Obtained: #{obtained}, Obtained At: #{obtained_at}, Sequence: #{sequence})"
  end
end
