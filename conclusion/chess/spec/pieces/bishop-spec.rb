require_relative '../../lib/pieces/bishop'

describe Bishop do
  let(:start_pos) { [5, 5] }
  let(:positions) { nil }
  let(:color) { 'white' }
  subject(:bishop) { described_class.new(color, start_pos, positions) }

  describe "#move" do
    context "when input is invalid" do
      it "returns INVALID when move is not in the same diagonal" do
        expect(bishop.move([0, 1])).to eq("INVALID")      
      end
      
      it "returns INVALID when move is not in the same diagonal" do
        expect(bishop.move([1, 0])).to eq("INVALID")      
      end

      it "returns INVALID when move is outside board boundary" do
        expect(bishop.move([8, 8])).to eq("INVALID")      
      end

      context "If there is a blocking piece, opposite color" do
        let(:positions) { {[6, 6] => {color: 'black', piece: 'rook'} }}
        let(:start_pos) { [0, 0] }

        it "returns INVALID when move is beyond the blocking piece" do
          expect(bishop.move([7, 7])).to eq("INVALID")
        end

        it "returns VALID when next move is at the blocking piece" do
          expect(bishop.move([6, 6])).to eq("VALID")
        end 
      end

      context "If there is a blocking piece, same color" do
        let(:positions) { {[6, 6] => {color: 'white', piece: 'rook'} }}
        let(:start_pos) { [0, 0] }

        it "returns INVALID when move is beyond the blocking piece" do
          expect(bishop.move([7, 7])).to eq("INVALID")
        end

        it "returns INVALID when next move is at the blocking piece" do
          expect(bishop.move([6, 6])).to eq("INVALID")
        end 
      end
    end

    context "when move is valid (diagonal)" do
      it "returns VALID for top-right moves" do
        expect(bishop.move([3, 7])).to eq("VALID")
      end

      it "returns VALID for top-left moves" do
        expect(bishop.move([0, 0])).to eq("VALID")
      end

      it "returns VALID for bottom-left moves" do
        expect(bishop.move([7, 3])).to eq("VALID")
      end

      it "returns VALID for bottom-right moves" do
        expect(bishop.move([7, 7])).to eq("VALID") 
      end
    end
  end
end