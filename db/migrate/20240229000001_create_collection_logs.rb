class CreateCollectionLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :collection_logs do |t|
      # t.string :user_id, null: false
      # t.string :collection_log_id, null: false

      t.timestamps
    end
  end
end
