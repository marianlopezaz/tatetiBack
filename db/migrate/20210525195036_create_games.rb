class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :player_id1, default: "1"
      t.string :player_id2, default: nil
      t.string :currentPlayer, default: "0"
      t.integer :moveNumber, default: 0
      t.integer :result
      t.string :board
  
      t.timestamps
    end
  end
end
