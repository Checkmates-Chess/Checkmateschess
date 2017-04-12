require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
	describe "test is_obstructed? method" do
		o = "open space"
		s = "start point"
		e = "end points"
		x = "piece"
		# unobstructed board
		board = [
							[e,o,o,o,o,o,e,o],
							[o,o,o,o,o,o,o,o],
							[o,o,o,o,o,o,o,o],
							[e,o,o,s,o,o,o,e],
							[o,o,o,o,o,o,o,o],
							[o,o,o,o,o,o,o,o],
							[e,o,o,o,o,o,o,o],
							[o,o,o,o,o,o,o,e],
						]
		# obstructed board
		board2 = [
				[e,o,o,e,o,o,e,o],
				[o,x,o,x,o,x,o,o],
				[o,o,o,o,o,o,o,o],
				[e,x,o,s,o,o,x,e],
				[o,o,o,o,o,o,o,o],
				[o,x,o,o,o,o,o,o],
				[e,o,o,x,o,o,x,o],
				[o,o,o,e,o,o,o,e],
			]
		piece = Piece.create(game_id: 1, piece_type: "Rook", piece_color: "white", piece_status: "alive", x_coordinate: 3, y_coordinate: 3)
		describe "when move is valid" do
			describe "when move is unobstructed" do
				describe "diagonal moves" do
					it "moves ne" do
						expect(piece.is_obstructed?(board, 3, 3, 0, 6)).to be(false)
					end			
					it "moves nw" do 
						expect(piece.is_obstructed?(board, 3, 3, 0, 0)).to be(false)
					end
					it "moves sw" do
						expect(piece.is_obstructed?(board, 3, 3, 6, 0)).to be(false)
					end
					it "moves se" do
						expect(piece.is_obstructed?(board, 3, 3, 7, 7)).to be(false)
					end
				end

				describe "straight moves(up,down,left,right" do
					it "moves left" do 
						expect(piece.is_obstructed?(board, 3, 3, 3, 0)).to be(false)
					end

					it "moves right" do 
						expect(piece.is_obstructed?(board, 3, 3, 3, 7)).to be(false)
					end

					it "moves up" do
						expect(piece.is_obstructed?(board, 3, 3, 7, 3)).to be(false)
					end

					it "moves down" do
						expect(piece.is_obstructed?(board, 3, 3, 7, 3)).to be(false)
					end
				end
			end
	
			
			describe "when move is obstructed" do
				describe "diagonal moves" do
					it "moves ne" do
						expect(piece.is_obstructed?(board2, 3, 3, 0, 6)).to be(true)
					end			
					it "moves nw" do 
						expect(piece.is_obstructed?(board2, 3, 3, 0, 0)).to be(true)
					end
					it "moves sw" do
						expect(piece.is_obstructed?(board2, 3, 3, 6, 0)).to be(true)
					end
					it "moves se" do
						expect(piece.is_obstructed?(board2, 3, 3, 7, 7)).to be(true)
					end
				end

				describe "straight moves(up,down,left,right" do
					it "moves left" do 
						expect(piece.is_obstructed?(board2, 3, 3, 3, 0)).to be(true)
					end

					it "moves right" do 
						expect(piece.is_obstructed?(board2, 3, 3, 3, 7)).to be(true)
					end

					it "moves up" do
						expect(piece.is_obstructed?(board2, 3, 3, 7, 3)).to be(true)
					end

					it "moves down" do
						expect(piece.is_obstructed?(board2, 3, 3, 7, 3)).to be(true)
					end
				end			
			end
		end
		describe "when move is invalid" do
			it "should be invalid when piece doesn't move" do
				expect {piece.is_obstructed?(board2,3,3,3,3)}.to raise_error(RuntimeError, 'Invalid Input, destination must be different from start')
			end

			it "should be invalid when not a straight or diagonal move" do
				expect {piece.is_obstructed?(board2,3,3,4,7)}.to raise_error(RuntimeError, 'Invalid Input, not a diagonal horizontal or vertical move')
			end
		end
	end

	describe "pieces#update" do
		it "should update (x, y) of piece to that of passed parameters" do
			user = FactoryGirl.create(:user, email: "piece#update_test_user@firehoseproject.com", username: "piece#update_test_username111")
			game = FactoryGirl.create(:game)
			piece = FactoryGirl.create(:piece, piece_type: "Bishop", x_coordinate: 5, y_coordinate: 5, user_id: user.id, game_id: game.id)
			sign_in user

			patch :update, params: { 
				id: piece.id, 
				piece: {
					x_coordinate: 4,
					y_coordinate: 4
				}
			}

			expect(response).to redirect_to game_path(piece.game)
			piece.reload
			expect(piece.x_coordinate).to eq(4)
			expect(piece.y_coordinate).to eq(4)
		end
	end

	describe "valid move method for pawn" do
		o = "open space"
		board = [[o, o, o, o, o, o, o, o],
						 [o, o, o, o, o, o, o, o],
						 [o, o, o, o, o, o, o, o],
						 [o, o, o, o, o, o, o, o],
						 [o, o, o, o, o, o, o, o],
						 [o, o, o, o, o, o, o, o],
						 [o, o, o, o, o, o, o, o],
						 [o, o, o, o, o, o, o, o]
						]

		# using to imitate piece_instance.piece_color for tests
		class PieceForValMove
		  attr_reader :piece_color
		  def initialize(piece_color)
		    @piece_color = piece_color
		  end
		end			

		#black piece moves
		it "should return true for black moving one forward if unobstructed" do
			user = FactoryGirl.create(:user, email: "user1110@firehoseproject.com", username: "user1110")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "", user_id: user.id)
			expect(pawn.valid_move?(board, [4, 2])).to eq(true)
		end

		it "should return true for black moving two forward if unobstructed and first move" do
			user = FactoryGirl.create(:user, email: "user1112@firehoseproject.com", username: "user1112")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "first move", user_id: user.id)
			expect(pawn.valid_move?(board, [4, 3])).to eq(true)
		end

		it "should return true for black moving one forward if unobstructed and first move" do
			user = FactoryGirl.create(:user, email: "user1113@firehoseproject.com", username: "user1113")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "first move", user_id: user.id)
			expect(pawn.valid_move?(board, [4, 2])).to eq(true)
		end

		it "should return false for black moving two forward if not first move" do
			user = FactoryGirl.create(:user, email: "user1114@firehoseproject.com", username: "user1114")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "", user_id: user.id)
			expect(pawn.valid_move?(board, [4, 3])).to eq(false)
		end

		it "should return true for black moving one move southwest if that square is occupied by white piece" do
			user = FactoryGirl.create(:user, email: "user1115@firehoseproject.com", username: "user1115")
			#other_user = FactoryGirl.create(:user, email: "user1116@firehoseproject.com", username: "user1116")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "", user_id: user.id)
			#enemy_piece = FactoryGirl.create(:piece, piece_type: "Rook", x_coordinate: 3, y_coordinate: 2, piece_color: "white", piece_status: "", user_id: other_user.id)
			enemy_piece = PieceForValMove.new("white")
			board[2][3] = enemy_piece
			expect(pawn.valid_move?(board, [3, 2])).to eq(true)
		end

		it "should return true for black moving one move southeast if that square is occupied by white piece" do
			user = FactoryGirl.create(:user, email: "user1117@firehoseproject.com", username: "user1117")
			#other_user = FactoryGirl.create(:user, email: "user1118@firehoseproject.com", username: "user1118")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "", user_id: user.id)
			#enemy_piece = FactoryGirl.create(:piece, piece_type: "Rook", x_coordinate: 5, y_coordinate: 2, piece_color: "white", piece_status: "", user_id: other_user.id)
			enemy_piece = PieceForValMove.new("white")
			board[2][5] = enemy_piece
			expect(pawn.valid_move?(board, [5, 2])).to eq(true)
		end

		it "should return false for black moving one move southwest if that square is occupied by black piece" do
			user = FactoryGirl.create(:user, email: "user1119@firehoseproject.com", username: "user1119")
			#other_user = FactoryGirl.create(:user, email: "user1120@firehoseproject.com", username: "user1120")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "", user_id: user.id)
			#friendly_piece = FactoryGirl.create(:piece, piece_type: "Rook", x_coordinate: 3, y_coordinate: 2, piece_color: "black", piece_status: "", user_id: other_user.id)
			friendly_piece = PieceForValMove.new("black")
			board[2][3] = friendly_piece
			expect(pawn.valid_move?(board, [3, 2])).to eq(false)
		end

		it "should return false for black moving one move southeast if that square is occupied by black piece" do
			user = FactoryGirl.create(:user, email: "user1121@firehoseproject.com", username: "user1121")
			#other_user = FactoryGirl.create(:user, email: "user1122@firehoseproject.com", username: "user1122")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "", user_id: user.id)
			#friendly_piece = FactoryGirl.create(:piece, piece_type: "Rook", x_coordinate: 5, y_coordinate: 2, piece_color: "black", piece_status: "", user_id: other_user.id)
			friendly_piece = PieceForValMove.new("black")
			board[2][5] = friendly_piece
			expect(pawn.valid_move?(board, [5, 2])).to eq(false)
		end

		it "should return false for black moving one move southwest if that square is unoccupied" do
			user = FactoryGirl.create(:user, email: "user1123@firehoseproject.com", username: "user1123")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "", user_id: user.id)
			board[2][3] = o
			expect(pawn.valid_move?(board, [3, 2])).to eq(false)
		end

		it "should return false for black moving one move southeast if that square is unoccupied" do
			user = FactoryGirl.create(:user, email: "user1124@firehoseproject.com", username: "user1124")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "", user_id: user.id)
			board[2][5] = o
			expect(pawn.valid_move?(board, [4, 3])).to eq(false)
		end

		# white piece moves
		it "should return true for white moving one forward if unobstructed" do
			user = FactoryGirl.create(:user, email: "user1130@firehoseproject.com", username: "user1130")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "", user_id: user.id)
			expect(pawn.valid_move?(board, [6, 5])).to eq(true)
		end

		it "should return true for white moving two forward if unobstructed and first move" do
			user = FactoryGirl.create(:user, email: "user1132@firehoseproject.com", username: "user1132")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "first move", user_id: user.id)
			expect(pawn.valid_move?(board, [6, 4])).to eq(true)
		end

		it "should return true for white moving one forward if unobstructed and first move" do
			user = FactoryGirl.create(:user, email: "user1133@firehoseproject.com", username: "user1133")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "first move", user_id: user.id)
			expect(pawn.valid_move?(board, [6, 5])).to eq(true)
		end

		it "should return false for white moving two forward if not first move" do
			user = FactoryGirl.create(:user, email: "user1134@firehoseproject.com", username: "user1134")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "", user_id: user.id)
			expect(pawn.valid_move?(board, [6, 4])).to eq(false)
		end

		it "should return true for white moving one move northwest if that square is occupied by black piece" do
			user = FactoryGirl.create(:user, email: "user1135@firehoseproject.com", username: "user1135")
			#other_user = FactoryGirl.create(:user, email: "user1116@firehoseproject.com", username: "user1116")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "", user_id: user.id)
			#enemy_piece = FactoryGirl.create(:piece, piece_type: "Rook", x_coordinate: 3, y_coordinate: 2, piece_color: "white", piece_status: "", user_id: other_user.id)
			enemy_piece = PieceForValMove.new("black")
			board[5][5] = enemy_piece
			expect(pawn.valid_move?(board, [5, 5])).to eq(true)
		end

		it "should return true for white moving one move northeast if that square is occupied by black piece" do
			user = FactoryGirl.create(:user, email: "user1137@firehoseproject.com", username: "user1137")
			#other_user = FactoryGirl.create(:user, email: "user1118@firehoseproject.com", username: "user1118")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "", user_id: user.id)
			#enemy_piece = FactoryGirl.create(:piece, piece_type: "Rook", x_coordinate: 5, y_coordinate: 2, piece_color: "white", piece_status: "", user_id: other_user.id)
			enemy_piece = PieceForValMove.new("black")
			board[5][7] = enemy_piece
			expect(pawn.valid_move?(board, [7, 5])).to eq(true)
		end

		it "should return false for white moving one move northwest if that square is occupied by white piece" do
			user = FactoryGirl.create(:user, email: "user1139@firehoseproject.com", username: "user1139")
			#other_user = FactoryGirl.create(:user, email: "user1120@firehoseproject.com", username: "user1120")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "", user_id: user.id)
			#friendly_piece = FactoryGirl.create(:piece, piece_type: "Rook", x_coordinate: 3, y_coordinate: 2, piece_color: "black", piece_status: "", user_id: other_user.id)
			friendly_piece = PieceForValMove.new("white")
			board[5][5] = friendly_piece
			expect(pawn.valid_move?(board, [5, 5])).to eq(false)
		end

		it "should return false for white moving one move northeast if that square is occupied by white piece" do
			user = FactoryGirl.create(:user, email: "user1141@firehoseproject.com", username: "user1141")
			#other_user = FactoryGirl.create(:user, email: "user1122@firehoseproject.com", username: "user1122")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "", user_id: user.id)
			#friendly_piece = FactoryGirl.create(:piece, piece_type: "Rook", x_coordinate: 5, y_coordinate: 2, piece_color: "black", piece_status: "", user_id: other_user.id)
			friendly_piece = PieceForValMove.new("white")
			board[5][7] = friendly_piece
			expect(pawn.valid_move?(board, [7, 5])).to eq(false)
		end

		it "should return false for white moving one move northwest if that square is unoccupied" do
			user = FactoryGirl.create(:user, email: "user1143@firehoseproject.com", username: "user1143")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "", user_id: user.id)
			board[5][5] = o
			expect(pawn.valid_move?(board, [5, 5])).to eq(false)
		end

		it "should return false for white moving one move northeast if that square is unoccupied" do
			user = FactoryGirl.create(:user, email: "user1144@firehoseproject.com", username: "user1144")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "", user_id: user.id)
			board[5][7] = o
			expect(pawn.valid_move?(board, [7, 5])).to eq(false)
		end

		it "should return false for white moving to a square that's not one/two forward or one diagonally" do
			user = FactoryGirl.create(:user, email: "user1145@firehoseproject.com", username: "user1145")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "", user_id: user.id)
			expect(pawn.valid_move?(board, [5, 4])).to eq(false)
		end

		it "should return false for black moving to a square that's not one/two forward or one diagonally" do
			user = FactoryGirl.create(:user, email: "user1146@firehoseproject.com", username: "user1146")
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "", user_id: user.id)
			expect(pawn.valid_move?(board, [3, 0])).to eq(false)
		end
	end

end


