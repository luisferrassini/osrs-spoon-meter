# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_301_152_747) do
  create_table 'collection_log_entries', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'tab_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['tab_id'], name: 'index_collection_log_entries_on_tab_id'
  end

  create_table 'collection_log_items', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'item_id', null: false
    t.integer 'quantity', null: false
    t.boolean 'obtained'
    t.datetime 'obtained_at'
    t.integer 'sequence'
    t.integer 'collection_log_entry_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['collection_log_entry_id'], name: 'index_collection_log_items_on_collection_log_entry_id'
  end

  create_table 'collection_logs', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'player_id'
    t.index ['player_id'], name: 'index_collection_logs_on_player_id'
  end

  create_table 'game_items', force: :cascade do |t|
    t.integer 'game_item_id'
    t.string 'name'
    t.datetime 'last_updated'
    t.boolean 'incomplete'
    t.boolean 'members'
    t.boolean 'tradeable'
    t.boolean 'tradeable_on_ge'
    t.boolean 'stackable'
    t.integer 'stacked'
    t.boolean 'noted'
    t.boolean 'noteable'
    t.integer 'linked_id_item'
    t.integer 'linked_id_noted'
    t.integer 'linked_id_placeholder'
    t.boolean 'placeholder'
    t.boolean 'equipable'
    t.boolean 'equipable_by_player'
    t.boolean 'equipable_weapon'
    t.integer 'cost'
    t.integer 'lowalch'
    t.integer 'highalch'
    t.float 'weight'
    t.integer 'buy_limit'
    t.boolean 'quest_item'
    t.datetime 'release_date'
    t.boolean 'duplicate'
    t.text 'examine'
    t.text 'icon'
    t.string 'wiki_name'
    t.string 'wiki_url'
    t.text 'equipment'
    t.text 'weapon'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'kill_counts', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'amount', null: false
    t.integer 'sequence', null: false
    t.integer 'collection_log_entry_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['collection_log_entry_id'], name: 'index_kill_counts_on_collection_log_entry_id'
  end

  create_table 'players', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index 'LOWER(name)', name: 'index_players_on_LOWER_name', unique: true
    t.index ['name'], name: 'index_players_on_name', unique: true
  end

  create_table 'tabs', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'collection_log_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['collection_log_id'], name: 'index_tabs_on_collection_log_id'
  end

  add_foreign_key 'collection_log_entries', 'tabs'
  add_foreign_key 'collection_log_items', 'collection_log_entries'
  add_foreign_key 'collection_logs', 'players'
  add_foreign_key 'kill_counts', 'collection_log_entries'
  add_foreign_key 'tabs', 'collection_logs'
end
