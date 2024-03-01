class AddUniqueLowerIndexToPlayersName < ActiveRecord::Migration[7.0]
  def change
    add_index :players, 'LOWER(name)', unique: true
  end
end
