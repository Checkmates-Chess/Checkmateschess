# require 'rails_helper'

# RSpec.describe Piece, type: :model do
# 	describe "test is_obstructed? method" do
# 		o = "open space"
# 		s = "start point"
# 		e = "end points"
# 		board = [
# 							[e,o,o,o,o,o,e,o],
# 							[o,o,o,o,o,o,o,o],
# 							[o,o,o,o,o,o,o,o],
# 							[e,o,o,s,o,o,o,e],
# 							[o,o,o,o,o,o,o,o],
# 							[o,o,o,o,o,o,o,o],
# 							[e,o,o,o,o,o,o,o],
# 							[o,o,o,o,o,o,o,e],
# 						]

# 		@piece = Piece.create(1,"rook","black","alive",3,3)
# 		describe "when move is valid" do
# 			describe "diagonal moves" do
# 				it "it moves ne" do
# 					@piece.is_obstructed?(board, 3, 3, 0, 6).should be(false)
# 				end
# 			end
# 		end
# 				# it "moves nw" do 

# 				# end
# 				# it "moves sw" do
				
# 				# end
# 				# it "moves se" do

# 				# end
# 	end
# end