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
			piece = Piece.create(piece_type: "Bishop", x_coordinate: 5, y_coordinate: 5, user_id: user.id, game_id: game.id)
			#piece = Piece.create(piece_type: "Bishop", x_coordinate: 5, y_coordinate: 5)
			sign_in user

			patch :update, params: { 
				id: piece.id, 
				piece: {
					x_coordinate: 4,
					y_coordinate: 4
				}
			}

			expect(piece.x_coordinate).to eq(4)
			expect(piece.y_coordinate).to eq(4)
			expect(response).to redirect_to game_path(piece.game)
		end
	end

end


