# db/migrate/20240229000002_create_tabs.rb
class CreateTabs < ActiveRecord::Migration[7.0]
  def change
    create_table :tabs do |t|
      t.string :name, null: false
      t.references :collection_log, foreign_key: true, null: false

      t.timestamps
    end
  end
end
