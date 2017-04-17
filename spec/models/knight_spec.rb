require 'rails_helper'

describe Knight do
  let(:game) { FactoryGirl.create(:game)}
    let(:init_coordinate) { { x: 2, y: 2 }}
    let(:knight) do
      FactoryGirl.create(:piece, piece_type: 'Knight', game: game, user: game.user,
        x_coordinate: init_coordinate[:x], y_coordinate: init_coordinate[:y])
    end
    let(:pawn) do
          FactoryGirl.create(:piece, piece_type: "Pawn", game: game, user: game.user, piece_color: "white")
    end
    let(:new_coordinate) { { x: 4, y: 3 } }

    #before do
    #  knight.move_to!(new_coordinate['x'], new_coordinate['y'])
    #end

    describe "#valid_move?" do
      context 'go to same square' do
        let(:new_coordinate) { init_coordinate }
        it { expect(knight.valid_move?(new_coordinate[:x], new_coordinate[:y])).to eq(false) }
      end

      context 'go down L' do
        let(:new_coordinate) { { x: 4, y: 3 } }
        it { expect(knight.valid_move?(new_coordinate[:x], new_coordinate[:y])).to eq(true)}
      end

      context 'go down backware L' do
        let(:new_coordinate) { { x: 4, y: 1 } }
        it { expect(knight.valid_move?(new_coordinate[:x], new_coordinate[:y])).to eq(true)}
      end

      context 'go up L' do
        let(:new_coordinate) { { x: 0, y: 1 } }
        it { expect(knight.valid_move?(new_coordinate[:x], new_coordinate[:y])).to eq(true) }
      end

      context 'go up backward L' do
        let(:new_coordinate) { { x: 0, y: 3 } }
        it { expect(knight.valid_move?(new_coordinate[:x], new_coordinate[:y])).to eq(true) }
      end
    end

    describe "#move_to!" do
      context "moves to specified x and y position" do
        let(:new_coordinate) { { x: 4, y: 3 } }
        it "should update x and y position" do
          knight.move_to!(new_coordinate[:x],new_coordinate[:y])
          expect(knight.x_coordinate).to eq(4)
          expect(knight.y_coordinate).to eq(3)
        end
      end

      context "captures a piece of opposite color" do

        let(:new_coordinate) { { x: 4, y: 3 } }
        it do
          knight.move_to!(new_coordinate[:x], new_coordinate[:y])
          expect(pawn.x_coordinate).to eq(nil)
        end
      end
    end

end
