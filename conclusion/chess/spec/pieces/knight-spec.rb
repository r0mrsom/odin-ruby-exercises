require_relative '../../lib/pieces/knight'

describe Knight do
  let(:start_pos) { [7, 5] }
  let(:positions) { nil }
  let(:color) { 'white' }
  subject(:knight) { described_class.new(color, start_pos, positions) }

  describe "#move" do
    context "when input is invalid" do
      it "returns INVALID when move is not in the end of L movement" do
        expect(knight.move([0, 1])).to eq("INVALID")      
      end
      
      it "returns INVALID when move is not in the end of L movement" do
        expect(knight.move([1, 0])).to eq("INVALID")      
      end

      it "returns INVALID when move is valid but outside board boundary" do
        expect(knight.move([8, 7])).to eq("INVALID")      
      end
    end

    context "when input has a piece with the opposite color" do
      let(:positions) { {[5, 4] => {color: 'black', piece: 'rook'} }}

      it "returns VALID" do
        expect(knight.move([5, 4])).to eq("VALID")
      end
    end

    context "when input has a piece with the same color" do
      let(:positions) { {[5, 4] => {color: 'white', piece: 'rook'} }}

      it "returns INVALID" do
        expect(knight.move([5, 4])).to eq("INVALID")
      end
    end

    context "when move is valid" do
      let(:start_pos) { [5, 5]}
      it "returns VALID when moved twice up then right" do
        expect(knight.move([3, 6])).to eq("VALID")
      end

      it "returns VALID when moved twice up then left" do
        expect(knight.move([3, 4])).to eq("VALID")
      end

      it "returns VALID when moved once up then twice right" do
        expect(knight.move([4, 7])).to eq("VALID")
      end

      it "returns VALID for moved once up then twice left" do
        expect(knight.move([4, 3])).to eq("VALID") 
      end

      it "returns VALID when moved once down then twice right" do
        expect(knight.move([6, 7])).to eq("VALID")
      end

      it "returns VALID when moved once down then twice left" do
        expect(knight.move([6, 3])).to eq("VALID")
      end

      it "returns VALID when moved twice down then right" do
        expect(knight.move([7, 6])).to eq("VALID")
      end

      it "returns VALID for moved twice down then left" do
        expect(knight.move([7, 4])).to eq("VALID") 
      end
    end
  end
end