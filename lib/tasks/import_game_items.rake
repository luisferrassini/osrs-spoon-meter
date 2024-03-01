require 'json'

namespace :import do
  desc 'Import game items from JSON'
  task game_items: :environment do
    data = JSON.parse(HTTParty.get('https://raw.githubusercontent.com/osrsbox/osrsbox-db/master/docs/items-complete.json'))

    data.each do |_key, item_data|
      GameItem.create!(
        game_item_id: item_data['id'],
        name: item_data['name'],
        last_updated: item_data['last_updated'],
        incomplete: item_data['incomplete'],
        members: item_data['members'],
        tradeable: item_data['tradeable'],
        tradeable_on_ge: item_data['tradeable_on_ge'],
        stackable: item_data['stackable'],
        stacked: item_data['stacked'],
        noted: item_data['noted'],
        noteable: item_data['noteable'],
        linked_id_item: item_data['linked_id_item'],
        linked_id_noted: item_data['linked_id_noted'],
        linked_id_placeholder: item_data['linked_id_placeholder'],
        placeholder: item_data['placeholder'],
        equipable: item_data['equipable'],
        equipable_by_player: item_data['equipable_by_player'],
        equipable_weapon: item_data['equipable_weapon'],
        cost: item_data['cost'],
        lowalch: item_data['lowalch'],
        highalch: item_data['highalch'],
        weight: item_data['weight'],
        buy_limit: item_data['buy_limit'],
        quest_item: item_data['quest_item'],
        release_date: item_data['release_date'],
        duplicate: item_data['duplicate'],
        examine: item_data['examine'],
        icon: item_data['icon'],
        wiki_name: item_data['wiki_name'],
        wiki_url: item_data['wiki_url'],
        equipment: item_data['equipment'],
        weapon: item_data['weapon']
      )
    end

    puts 'Game items imported successfully!'
  end
end
