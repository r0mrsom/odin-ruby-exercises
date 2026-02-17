require_relative '../../lib/pieces/queen'

describe Queen do
  let(:start_pos) { [5, 5] }
  let(:positions) { nil }
  let(:color) { 'white' }
  subject(:queen) { described_class.new(color, start_pos, positions) }

  describe "#move" do
    context "when input is invalid" do
      it "returns INVALID when move is not in the same diagonal or row or column" do
        expect(queen.move([0, 1])).to eq("INVALID")
      end
      
      it "returns INVALID when move is not in the same diagonal or row or column" do
        expect(queen.move([1, 0])).to eq("INVALID")
      end

      it "returns INVALID when move is outside board boundary (test 1)" do
        expect(queen.move([8, 5])).to eq("INVALID")   
      end

      it "returns INVALID when move is outside board boundary (test 2)" do
        expect(queen.move([8, 8])).to eq("INVALID")   
      end

      context "If there is a blocking piece (diagonal) with opposite color" do
        let(:positions) { {[6, 6] => {color: 'black', piece: 'rook'} }}
        let(:start_pos) { [0, 0] }

        it "returns INVALID when move is beyond the blocking piece" do
          expect(queen.move([7, 7])).to eq("INVALID")
        end

        it "returns VALID when next move is at the blocking piece" do
          expect(queen.move([6, 6])).to eq("VALID")
        end 
      end

      context "If there is a blocking piece (diagonal) with same color" do
        let(:positions) { {[6, 6] => {color: 'white', piece: 'rook'} }}
        let(:start_pos) { [0, 0] }

        it "returns INVALID when move is beyond the blocking piece" do
          expect(queen.move([7, 7])).to eq("INVALID")
        end

        it "returns INVALID when next move is at the blocking piece" do
          expect(queen.move([6, 6])).to eq("INVALID")
        end 
      end

      context "If there is a blocking piece (row or column) with opposite color" do
        let(:positions) { {[3, 5] => {color: 'black', piece: 'rook'} }}
        let(:start_pos) { [1, 5] }

        it "returns INVALID when move is beyond the blocking piece" do
          expect(queen.move([7, 5])).to eq("INVALID")
        end

        it "returns VALID when next move is at the blocking piece" do
          expect(queen.move([3, 5])).to eq("VALID")
        end 
      end

      context "If there is a blocking piece (row or column) with same color" do
        let(:positions) { {[3, 5] => {color: 'white', piece: 'rook'} }}
        let(:start_pos) { [1, 5] }

        it "returns INVALID when move is beyond the blocking piece" do
          expect(queen.move([7, 5])).to eq("INVALID")
        end

        it "returns INVALID when next move is at the blocking piece" do
          expect(queen.move([3, 5])).to eq("INVALID")
        end 
      end
    end

    context "when move is valid" do
      it "returns VALID for top moves" do
        expect(queen.move([0, 5])).to eq("VALID")
      end

      it "returns VALID for down moves" do
        expect(queen.move([7, 5])).to eq("VALID")
      end

      it "returns VALID for left moves" do
        expect(queen.move([5, 1])).to eq("VALID") 
      end

      it "returns VALID for right moves" do
        expect(queen.move([5, 7])).to eq("VALID") 
      end
      
      it "returns VALID for top-right moves" do
        expect(queen.move([3, 7])).to eq("VALID")
      end

      it "returns VALID for top-left moves" do
        expect(queen.move([0, 0])).to eq("VALID")
      end

      it "returns VALID for bottom-left moves" do
        expect(queen.move([7, 3])).to eq("VALID")
      end

      it "returns VALID for bottom-right moves" do
        expect(queen.move([7, 7])).to eq("VALID") 
      end
    end
  end
end