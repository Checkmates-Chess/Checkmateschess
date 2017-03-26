class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.integer :player_id
      t.integer :game_id
      t.string :piece_type
      t.string :piece_color
      t.string :piece_status
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.integer :piece_id
      t.timestamps
    end
  end
end
