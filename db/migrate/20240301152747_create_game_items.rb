class CreateGameItems < ActiveRecord::Migration[7.0]
  def change
    create_table :game_items do |t|
      t.integer :game_item_id
      t.string :name
      t.datetime :last_updated
      t.boolean :incomplete
      t.boolean :members
      t.boolean :tradeable
      t.boolean :tradeable_on_ge
      t.boolean :stackable
      t.integer :stacked
      t.boolean :noted
      t.boolean :noteable
      t.integer :linked_id_item
      t.integer :linked_id_noted
      t.integer :linked_id_placeholder
      t.boolean :placeholder
      t.boolean :equipable
      t.boolean :equipable_by_player
      t.boolean :equipable_weapon
      t.integer :cost
      t.integer :lowalch
      t.integer :highalch
      t.float :weight
      t.integer :buy_limit
      t.boolean :quest_item
      t.datetime :release_date
      t.boolean :duplicate
      t.text :examine
      t.text :icon
      t.string :wiki_name
      t.string :wiki_url
      t.text :equipment
      t.text :weapon

      t.timestamps
    end
  end
end
