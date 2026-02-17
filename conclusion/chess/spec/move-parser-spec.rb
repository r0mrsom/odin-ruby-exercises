require_relative '../lib/move-parser'

describe MoveParser do
  subject(:test) { described_class.new }

  describe "#convert" do
    context "Moving pawn" do
      it "Convert b4 to [nil, [4, 1]]" do
        input = "b4"
        expect(test.convert(input)).to eql([nil, [4, 1]]) # Row: 8-4=4, Col: b=1
      end

      it "Convert d8 to [nil, [0, 3]]" do
        input = "d8"
        expect(test.convert(input)).to eql([nil, [0, 3]]) # Row: 8-8=0, Col: d=3
      end

      it "Convert h3g4 to [[5, 7], [4, 6]]" do
        input = "h3g4"
        expect(test.convert(input)).to eql([[5, 7], [4, 6]]) # h3: [5, 7], g4: [4, 6]
      end

      it "Convert Ph3g4 to [[5, 7], [4, 6]]" do
        input = "Ph3g4"
        expect(test.convert(input)).to eql([[5, 7], [4, 6]]) # Same as coordinate move
      end
    end

    context "Moving knight" do
      it "Convert Nb4 to [nil, [4, 1]]" do
        input = "Nb4"
        expect(test.convert(input)).to eql([nil, [4, 1]])
      end

      it "Convert Nd8 to [nil, [0, 3]]" do
        input = "Nd8"
        expect(test.convert(input)).to eql([nil, [0, 3]])
      end

      it "Convert Nef3 to [4, [5, 5]]" do
        input = "Nef3"
        expect(test.convert(input)).to eql([4, [5, 5]]) # Disambiguator: e=4, Target f3: [5, 5]
      end
    end

    context "Moving rook" do
      it "Convert Rh1 to [nil, [7, 7]]" do
        input = "Rh1"
        expect(test.convert(input)).to eql([nil, [7, 7]]) # Row: 8-1=7, Col: h=7
      end

      it "Convert Rc5 to [nil, [3, 2]]" do
        input = "Rc5"
        expect(test.convert(input)).to eql([nil, [3, 2]]) # Row: 8-5=3, Col: c=2
      end
    end

    context "Moving bishop" do
      it "Convert Bh2 to [nil, [6, 7]]" do
        input = "Bh2"
        expect(test.convert(input)).to eql([nil, [6, 7]]) # Row: 8-2=6, Col: h=7
      end

      it "Convert Bc6 to [nil, [2, 2]]" do
        input = "Bc6"
        expect(test.convert(input)).to eql([nil, [2, 2]]) # Row: 8-6=2, Col: c=2
      end
      
      it "Convert Bc6b5 to [[2, 2], [3, 1]]" do
        input = "Bc6b5"
        expect(test.convert(input)).to eql([[2, 2], [3, 1]]) # c6: [2, 2], b5: [3, 1]
      end
    end

    context "Moving queen" do
      it "Convert Qg8 to [nil, [0, 6]]" do
        input = "Qg8"
        expect(test.convert(input)).to eql([nil, [0, 6]]) # Row: 8-8=0, Col: g=6
      end

      it "Convert Qc6 to [nil, [2, 2]]" do
        input = "Qc6"
        expect(test.convert(input)).to eql([nil, [2, 2]]) # Row: 8-6=2, Col: c=2
      end
    end

    context "Moving king" do
      it "Convert Ke3 to [nil, [5, 4]]" do
        input = "Ke3"
        expect(test.convert(input)).to eql([nil, [5, 4]]) # Row: 8-3=5, Col: e=4
      end

      it "Convert Ka5 to [nil, [3, 0]]" do
        input = "Ka5"
        expect(test.convert(input)).to eql([nil, [3, 0]]) # Row: 8-5=3, Col: a=0
      end
    end

    context "Testing invalid inputs" do
      it "returns nil when input does not match the pattern" do
        input = "Kasdfe22"
        expect(test.convert(input)).to eql(nil)
      end

      it "returns nil when input is outside the board boundary" do
        input = "Ki9"
        expect(test.convert(input)).to eql(nil)
      end
    end
  end
end