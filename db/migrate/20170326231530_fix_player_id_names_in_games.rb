class FixPlayerIdNamesInGames < ActiveRecord::Migration[5.0]
  def change
    rename_column :games, :player1_id, :player_black_id
    rename_column :games, :player2_id, :player_white_id
  end
end
