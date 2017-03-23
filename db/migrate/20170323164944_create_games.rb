class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :game_title
      t.integer :player1_id
      t.integer :player2_id
      t.string :player_turn
      t.integer :winner_id
      t.integer :game_id
      t.timestamps
    end
  end
end
