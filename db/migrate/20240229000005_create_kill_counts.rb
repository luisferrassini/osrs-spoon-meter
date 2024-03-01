# db/migrate/20240229000005_create_kill_counts.rb
class CreateKillCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :kill_counts do |t|
      t.string :name, null: false
      t.integer :amount, null: false
      t.integer :sequence, null: false
      t.references :collection_log_entry, foreign_key: true, null: false

      t.timestamps
    end
  end
end
