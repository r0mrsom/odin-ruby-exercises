require_relative '../../lib/pieces/rook'

describe Rook do
  let(:start_pos) { [5, 5] }
  let(:positions) { nil }
  let(:color) { 'white'}
  subject(:bishop) { described_class.new(color, start_pos, positions) }

  describe "#move" do
    context "when input is invalid" do
      it "returns INVALID when move is not in the same row or column" do
        expect(bishop.move([0, 1])).to eq("INVALID")
      end
      
      it "returns INVALID when move is not in the same row or column" do
        expect(bishop.move([1, 0])).to eq("INVALID")
      end

      it "returns INVALID when move is outside board boundary" do
        expect(bishop.move([8, 5])).to eq("INVALID")   
      end

      context "If there is a blocking piece with opposite color" do
        let(:positions) { {[3, 5] => {color: 'black', piece: 'rook'} }}
        let(:start_pos) { [1, 5] }

        it "returns INVALID when move is beyond the blocking piece" do
          expect(bishop.move([7, 5])).to eq("INVALID")
        end

        it "returns VALID when next move is at the blocking piece" do
          expect(bishop.move([3, 5])).to eq("VALID")
        end 
      end

      context "If there is a blocking piece with same color" do
        let(:positions) { {[3, 5] => {color: 'white', piece: 'rook'} }}
        let(:start_pos) { [1, 5] }

        it "returns INVALID when move is beyond the blocking piece" do
          expect(bishop.move([7, 5])).to eq("INVALID")
        end

        it "returns INVALID when next move is at the blocking piece" do
          expect(bishop.move([3, 5])).to eq("INVALID")
        end 
      end
    end

    context "when move is valid" do
      it "returns VALID for top moves" do
        expect(bishop.move([0, 5])).to eq("VALID")
      end

      it "returns VALID for down moves" do
        expect(bishop.move([7, 5])).to eq("VALID")
      end

      it "returns VALID for left moves" do
        expect(bishop.move([5, 1])).to eq("VALID") 
      end

      it "returns VALID for right moves" do
        expect(bishop.move([5, 7])).to eq("VALID") 
      end
    end
  end
end