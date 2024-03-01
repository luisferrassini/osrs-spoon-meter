class CreateCollectionLogEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :collection_log_entries do |t|
      t.string :name, null: false
      t.references :tab, foreign_key: true, null: false

      t.timestamps
    end
  end
end
