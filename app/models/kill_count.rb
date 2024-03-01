class KillCount < ApplicationRecord
  belongs_to :collection_log_entry

  validates :name, presence: true
  validates :amount, presence: true
  validates :sequence, presence: true

  def to_s
    "#{name}: #{amount} (Sequence: #{sequence})"
  end
end
