class AlterPiecesAddUserId < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :user_id, :integer
    add_index :pieces, :user_id
  end
end
