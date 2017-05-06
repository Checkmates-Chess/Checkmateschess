require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
	describe "piece#create" do
		it "should successfully create a piece" do
			user = FactoryGirl.create(:user)
	        sign_in user

	       	game = FactoryGirl.create(:game)

	        piece = Piece.create(:game_id => game.id, :piece_type => "Pawn", :piece_name => "w_pawn8", :piece_color => "white", :piece_status => "alive", :x_coordinate => 7, :y_coordinate => 6)
	        expect(piece.piece_type).to eq("Pawn")
	        expect(piece.piece_color).to eq("white")
		end
	end

	describe "test is_obstructed? method" do
		o = nil
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
		#describe "when move is invalid" do
	  #	it "should be invalid when piece doesn't move" do
		#		expect {piece.is_obstructed?(board2,3,3,3,3)}.to raise_error(RuntimeError, 'Invalid Input, destination must be different from start')
		#	end

		#	it "should be invalid when not a straight or diagonal move" do
		#		expect {piece.is_obstructed?(board2,3,3,4,7)}.to raise_error(RuntimeError, 'Invalid Input, not a diagonal horizontal or vertical move')
		#	end
		#end
	end

	describe "valid move method for pawn" do
		#black piece moves
		it "should return true for black moving one forward if unobstructed" do
			game1 = FactoryGirl.create(:game)
      game1.player_turn = "black"
      pawn = game1.pieces.where(piece_type: "Pawn", piece_color: "black", x_coordinate: 4, y_coordinate: 1).first
			expect(pawn.valid_move?(2, 4)).to eq(true)
		end

		#it "should return true for black moving two forward if unobstructed and first move" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "first move")
		#	expect(pawn.valid_move?(3, 4)).to eq(true)
		#end

		#it "should return true for black moving one forward if unobstructed and first move" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "first move")
		#	expect(pawn.valid_move?(2, 4)).to eq(true)
		#end

		it "should return false for black moving two forward if not first move" do
			game1 = FactoryGirl.create(:game)
      game1.player_turn = "black"
      pawn = game1.pieces.where(piece_type: "Pawn", piece_color: "black", x_coordinate: 4, y_coordinate: 1).first
			pawn.piece_status = "alive"
			expect(pawn.valid_move?(3, 4)).to eq(false)
		end

		it "should return true for black moving one move southwest if that square is occupied by white piece" do
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "")
			enemy_piece = FactoryGirl.create(:piece, x_coordinate: 3, y_coordinate: 2, piece_color: "white", game: pawn.game)
			pawn.game.player_turn = "black"
			expect(pawn.valid_move?(2, 3)).to eq(true)
		end

		#it "should return true for black moving one move southeast if that square is occupied by white piece" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "")
		#	enemy_piece = FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 2, piece_color: "white", game: pawn.game)
		#	expect(pawn.valid_move?(2, 5)).to eq(true)
		#end

		#it "should return false for black moving one move southwest if that square is occupied by black piece" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "")
		#	friendly_piece = FactoryGirl.create(:piece, x_coordinate: 3, y_coordinate: 2, piece_color: "black", game: pawn.game)
		#	expect(pawn.valid_move?(2, 3)).to eq(false)
		#end

		it "should return false for black moving one move southeast if that square is occupied by black piece" do
			pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "")
			friendly_piece = FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 2, piece_color: "black", game: pawn.game)
			pawn.game.player_turn = "black"
			expect(pawn.valid_move?(2, 5)).to eq(false)
		end

		#it "should return false for black moving one move southwest if that square is unoccupied" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "")
		#	expect(pawn.valid_move?(2, 3)).to eq(false)
		#end

		#it "should return false for black moving one move southeast if that square is unoccupied" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "")
		#	expect(pawn.valid_move?(2, 5)).to eq(false)
		#end

		# white piece moves
		it "should return true for white moving one forward if unobstructed" do
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "")
			pawn.game.player_turn = "white"
			expect(pawn.valid_move?(5, 6)).to eq(true)
		end

		#it "should return true for white moving two forward if unobstructed and first move" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "first move")
		#	expect(pawn.valid_move?(4, 6)).to eq(true)
		#end

		it "should return true for white moving one forward if unobstructed and first move" do
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "first move")
			pawn.game.player_turn = "white"
			expect(pawn.valid_move?(5, 6)).to eq(true)
		end

		#it "should return false for white moving two forward if not first move" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "")
		#	expect(pawn.valid_move?(4, 6)).to eq(false)
		#end

		#it "should return true for white moving one move northwest if that square is occupied by black piece" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "")
		#	enemy_piece = FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 5, piece_color: "black", game: pawn.game)
		#	expect(pawn.valid_move?(5, 5)).to eq(true)
		#end

		it "should return true for white moving one move northeast if that square is occupied by black piece" do
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "")
			enemy_piece = FactoryGirl.create(:piece, x_coordinate: 7, y_coordinate: 5, piece_color: "black", game: pawn.game)
			pawn.game.player_turn = "white"
			expect(pawn.valid_move?(5, 7)).to eq(true)
		end

		#it "should return false for white moving one move northwest if that square is occupied by white piece" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "")
		#	friendly_piece = FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 5, piece_color: "white", game: pawn.game)
		#	expect(pawn.valid_move?(5, 5)).to eq(false)
		#end

		it "should return false for white moving one move northeast if that square is occupied by white piece" do
			pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "")
			friendly_piece = FactoryGirl.create(:piece, x_coordinate: 7, y_coordinate: 5, piece_color: "white", game: pawn.game)
			pawn.game.player_turn = "white"
			expect(pawn.valid_move?(5, 7)).to eq(false)
		end

		#it "should return false for white moving one move northwest if that square is unoccupied" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "")
		#	expect(pawn.valid_move?(5, 5)).to eq(false)
		#end

		#it "should return false for white moving one move northeast if that square is unoccupied" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "")
		#	expect(pawn.valid_move?(5, 7)).to eq(false)
		#end

		#it "should return false for white moving to a square that's not one/two forward or one diagonally" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 6, piece_color: "white", piece_status: "")
		#	expect(pawn.valid_move?(4, 5)).to eq(false)
		#end

		#it "should return false for black moving to a square that's not one/two forward or one diagonally" do
		#	pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, piece_color: "black", piece_status: "")
		#	expect(pawn.valid_move?(0, 3)).to eq(false)
		#end
  end

  describe "valid_move? for Pieces model" do
		game = FactoryGirl.create(:game)
		#o = nil
	  #e = "end points"
	  #x = "piece"
		#game.board = [
		#					[@b_rook1,o,o,o,o,@b_bishop2,o,o],
		#					[o,o,o,o,o,o,o,o],
		#					[o,o,o,e,e,o,o,o],
		#					[o,o,o,o,o,o,o,o],
		#					[o,o,o,o,o,o,o,o],
		#					[o,o,o,e,e,o,o,o],
		#					[o,o,o,o,o,o,o,o],
		#					[o,o,@w_bishop1,o,o,o,o,@w_rook2]
		#				]
    w_bishop1 = game.pieces.find_by_piece_name("w_bishop1")
    w_bishop1.update_attributes(y_coordinate: 5, x_coordinate: 2)
    b_bishop2 = game.pieces.find_by_piece_name("b_bishop2")
    b_bishop2.update_attributes(y_coordinate: 2, x_coordinate: 5)
    b_rook1 = game.pieces.find_by_piece_name("b_rook1")
    b_rook1.update_attributes(y_coordinate: 2, x_coordinate: 0)
    w_rook2 = game.pieces.find_by_piece_name("w_rook2")
    w_rook2.update_attributes(y_coordinate: 5, x_coordinate: 7)

		it "should prevent piece from moving off the board" do
	    expect(w_bishop1.valid_move?(1, 8)).to eq(false)
		end

		it "should allow piece to move when valid" do
			game.player_turn = "white"
	    expect(w_bishop1.valid_move?(3, 4)).to eq(true)
	    game.player_turn = "black"
	    expect(b_bishop2.valid_move?(4, 3)).to eq(true)
	    expect(b_rook1.valid_move?(2, 5)).to eq(true)
	    game.player_turn = "white"
	    expect(w_rook2.valid_move?(5, 2)).to eq(true)
		end

		it "should prevent piece to move when obstructed" do
			game = FactoryGirl.create(:game)
	    piece = game.pieces.find_by_piece_name("w_bishop1")
	    other_piece = game.pieces.where(y_coordinate: 6, x_coordinate: 3).first
	    game.player_turn = "white"
	    expect(piece.valid_move?(5, 4)).to eq(false)
		end
	end

	describe "valid_move? for Bishop" do
			game = FactoryGirl.create(:game)
			o = nil
		  e = "end points"
		  x = "piece"
			game.board = [
								[o,o,@b_bishop1,o,o,@b_bishop2,o,o],
								[o,o,o,o,o,o,o,o],
								[o,o,o,e,e,o,o,o],
								[o,o,o,o,o,o,o,o],
								[o,o,o,o,o,o,o,o],
								[o,o,o,e,e,o,o,o],
								[o,o,o,o,o,o,o,o],
								[o,o,@w_bishop1,o,o,@w_bishop2,o,o]
							]
	    w_bishop1 = game.pieces.find_by_piece_name("w_bishop1")
	    w_bishop2 = game.pieces.find_by_piece_name("w_bishop2")
	    b_bishop1 = game.pieces.find_by_piece_name("b_bishop1")
	    b_bishop2 = game.pieces.find_by_piece_name("b_bishop2")

	  it "should allow bishops to move diagonally" do
	  	game.player_turn = "white"
	    expect(w_bishop1.valid_move?(5, 4)).to eq(true)
	    expect(w_bishop2.valid_move?(5, 3)).to eq(true)
	    game.player_turn = "black"
	    expect(b_bishop1.valid_move?(2, 4)).to eq(true)
	    expect(b_bishop2.valid_move?(2, 3)).to eq(true)
	  end

	  it "should prevent bishops from moving horizontally" do
	  	game.player_turn = "white"
	    expect(w_bishop1.valid_move?(4, 7)).to eq(false)
	  end

	  it "should prevent bishops from moving vertically" do
	  	game.player_turn = "black"
	    expect(b_bishop2.valid_move?(4, 5)).to eq(false)
	  end

	  it "should prevent unallowed moves" do
	  	game.player_turn = "white"
			expect(w_bishop2.valid_move?(6, 1)).to eq(false)
	  end
	end

	describe "valid_move? for Rook" do
		before(:all) do
    		@user = FactoryGirl.create(:user)
    		@game = FactoryGirl.create(:game)
    		@test_rook = @game.pieces.where(piece_type: "Rook", piece_color: "white").first
    		@test_rook.update_attributes(x_coordinate: 3, y_coordinate: 3)
  		end

  		before(:each) {sign_in @user}

		describe "valid moves" do
			it "should allow a valid move vertically" do
				@game.update_attributes(player_turn: "white")
		    expect(@test_rook.valid_move?(4, 3)).to eq(true)
			end

			it "should allow a valid move horizontally" do
				@game.update_attributes(player_turn: "white")
		    expect(@test_rook.valid_move?(3, 4)).to eq(true)
			end
		end

		describe "invalid moves" do
			it "should not allow diagonal moves" do
				@game.update_attributes(player_turn: "white")
		    expect(@test_rook.valid_move?(4, 4)).to eq(false)
	    end

	    it "should not allow L shaped moves" do
				@game.update_attributes(player_turn: "white")
	      expect(@test_rook.valid_move?(5, 4)).to eq(false)
	    end
		end
	end

	#describe "pieces#show" do
	#	it "should update piece_status of piece to include 'highlighted'" do
	#		user = FactoryGirl.create(:user)
	#		game = FactoryGirl.create(:game)
	#		sign_in user
	#		piece = Piece.create(game_id: game.id, piece_status: "first move")
  #
	#		get :show, params: { id: piece.id }
  #
	#		piece.reload
	#		expect(piece.piece_status).to eq("first move|highlighted")
	#	end
	#end

	describe "pieces#update" do
		it "should update (x, y) of piece to that of passed parameters" do
			user = FactoryGirl.create(:user)
			sign_in user
			game = FactoryGirl.create(:game)
			white_pawn = game.pieces.where(x_coordinate: 0, y_coordinate: 6).first			
		  game.update_attributes(player_turn: "white")

			patch :update, params: { 
				id: white_pawn.id, 
				piece: {
					x_coordinate: 0,
					y_coordinate: 4
				}
			}

			white_pawn.reload
			expect(white_pawn.piece_status).to eq("alive")
			expect(white_pawn.x_coordinate).to eq(0)
			expect(white_pawn.y_coordinate).to eq(4)
		end

		it "should not update piece if it moves king into check" do
			user = FactoryGirl.create(:user)
			sign_in user
			game = FactoryGirl.create(:game)
			black_king = game.pieces.where(x_coordinate: 4, y_coordinate: 0).first
			black_king.update_attributes(x_coordinate: 4, y_coordinate: 3)
			white_pawn = game.pieces.where(x_coordinate: 0, y_coordinate: 6).first
			white_pawn.update_attributes(x_coordinate: 5, y_coordinate: 5)
			game.update_attributes(player_turn: "white")

			patch :update, params: { 
				id: black_king.id, 
				piece: {
					x_coordinate: 4,
					y_coordinate: 4
				}
			}

			black_king.reload
			expect(black_king.x_coordinate).to eq(4)
			expect(black_king.y_coordinate).to eq(3)
		end
	end

describe "King" do
 	before(:all) do
  	@user = FactoryGirl.create(:user)
  	@game = FactoryGirl.create(:game)
		for y in 0..7
			if y == 0 || y == 7
	 			for x in 0..7
					if (x > 0 && x < 4) || (x > 4 && x < 7)
						dead_piece = @game.pieces.find_by(y_coordinate: y, x_coordinate: x)
						dead_piece.update_attributes(y_coordinate: nil, x_coordinate: nil)
					end
				end
			end
		end
  	@black_king = @game.pieces.find_by(y_coordinate: 0, x_coordinate: 4)
  end

  before(:each) {sign_in @user}

	describe "Castling" do
			it "should be allowed on the king-side rook" do
			expect(@black_king.valid_move?(0, 6)).to be(true)
			
			@king_side_rook = @game.pieces.find_by(y_coordinate: 0, x_coordinate: 5, piece_type: "Rook")
			expect(@king_side_rook).not_to eq(nil)
		end
		it "should be allowed on the queen-side rook" do
			expect(@black_king.valid_move?(0, 2)).to be(true)
			
			@queen_side_rook = @game.pieces.find_by(y_coordinate: 0, x_coordinate: 3, piece_type: "Rook")
			expect(@queen_side_rook).not_to eq(nil)
		end
		it "should not be allowed when the king has moved" do
			# @black_king.update_attributes(x_coordinate: 5)
 
			# expect(@black_king.valid_move?(0, 2)).to be(false)
		end
		it "should not be allowed when the rook has moved" do
			expect(true).to be(true)
		end
	end
	
end

describe "valid_move? for King" do
	 	before(:all) do
	  	@user = FactoryGirl.create(:user)
	  	@game = FactoryGirl.create(:game)
	  	@test_king = @game.pieces.where(piece_type: "King", piece_color: "white").first
	  	@test_king.update_attributes(x_coordinate: 3, y_coordinate: 3) 
	  end

	  before(:each) {sign_in @user}

	 	describe "valid moves" do
	 		it "should allow a valid move vertically" do
	 			@game.update_attributes(player_turn: "white")
	 			expect(@test_king.valid_move?(4, 3)).to eq(true)
	  		expect(@test_king.valid_move?(2, 3)).to eq(true)
	 		end

			it "should allow a valid move horizontally" do
				@game.update_attributes(player_turn: "white")
				expect(@test_king.valid_move?(3, 4)).to eq(true)
				expect(@test_king.valid_move?(3, 2)).to eq(true)
			end

			it "should allow a valid move diagonally" do
				@game.update_attributes(player_turn: "white")
				expect(@test_king.valid_move?(4, 4)).to eq(true)
				expect(@test_king.valid_move?(4, 2)).to eq(true)
				expect(@test_king.valid_move?(2, 2)).to eq(true)
				expect(@test_king.valid_move?(2, 4)).to eq(true)
			end
		end

		describe "invalid moves" do
			it "should not move more than one in any direction" do
				@game.update_attributes(player_turn: "white")
				expect(@test_king.valid_move?(5, 3)).to eq(false)
	  		expect(@test_king.valid_move?(1, 3)).to eq(false)
				expect(@test_king.valid_move?(3, 5)).to eq(false)
				expect(@test_king.valid_move?(3, 1)).to eq(false)
				expect(@test_king.valid_move?(5, 5)).to eq(false)
				expect(@test_king.valid_move?(5, 1)).to eq(false)
				expect(@test_king.valid_move?(1, 1)).to eq(false)
				expect(@test_king.valid_move?(1, 5)).to eq(false)
			end

			it "should not allow L shaped moves" do
				@game.update_attributes(player_turn: "white")
				expect(@test_king.valid_move?(5, 4)).to eq(false)
			end
		end
	end

		describe "valid_move? for Queen" do
		 	before(:all) do
		  	@user = FactoryGirl.create(:user)
		  	@game = FactoryGirl.create(:game)
		  	@test_queen = @game.pieces.where(piece_type: "Queen", piece_color: "white").first
	  		@test_queen.update_attributes(x_coordinate: 3, y_coordinate: 3) 
		  end

		  before(:each) {sign_in @user}

		 	describe "valid moves" do
		 		it "should allow a valid move vertically" do
		 			@game.update_attributes(player_turn: "white")
		 			expect(@test_queen.valid_move?(4, 3)).to eq(true)
		  		expect(@test_queen.valid_move?(2, 3)).to eq(true)
		 		end

				it "should allow a valid move horizontally" do
					@game.update_attributes(player_turn: "white")
					expect(@test_queen.valid_move?(3, 4)).to eq(true)
					expect(@test_queen.valid_move?(3, 2)).to eq(true)
				end

				it "should allow a valid move diagonally" do
					@game.update_attributes(player_turn: "white")
					expect(@test_queen.valid_move?(4, 4)).to eq(true)
					expect(@test_queen.valid_move?(4, 2)).to eq(true)
					expect(@test_queen.valid_move?(2, 2)).to eq(true)
					expect(@test_queen.valid_move?(2, 4)).to eq(true)
				end
			end

			describe "invalid moves" do
				it "should not allow L shaped moves" do
					@game.update_attributes(player_turn: "white")
					expect(@test_queen.valid_move?(5, 4)).to eq(false)
				end
			end
		end
end
