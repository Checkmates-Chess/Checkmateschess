class RemovePieceIdAndPlayerIdFromPieces < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :piece_id, :integer
    remove_column :pieces, :player_id, :integer
  end
end
