class AddPieceNameToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :piece_name, :string
  end
end
