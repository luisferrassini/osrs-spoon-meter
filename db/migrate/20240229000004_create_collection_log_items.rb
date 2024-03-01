class CreateCollectionLogItems < ActiveRecord::Migration[7.0]
  def change
    create_table :collection_log_items do |t|
      t.string :name, null: false
      t.integer :item_id, null: false
      t.integer :quantity, null: false
      t.boolean :obtained, null: true
      t.datetime :obtained_at, null: true
      t.integer :sequence, null: true
      t.references :collection_log_entry, foreign_key: true, null: false

      t.timestamps
    end
  end
end
