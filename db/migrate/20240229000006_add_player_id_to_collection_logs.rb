class AddPlayerIdToCollectionLogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :collection_logs, :player, foreign_key: true
  end
end
