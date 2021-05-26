class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :player_id1, default: "1"
      t.string :player_id2, default: "2"
      t.string :board
  
      t.timestamps
    end
  end
end
