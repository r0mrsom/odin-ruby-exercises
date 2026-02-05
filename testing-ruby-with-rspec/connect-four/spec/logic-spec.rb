require_relative '../lib/logic'

describe Logic do
  subject(:test) {described_class.new}

  describe '#check_win' do
    context "When there are no winning combinations" do
      it "return nil if empty board" do
        input = Array.new(6) {Array.new(7, 0)}
        expect(test.check_win(input)).to be_nil
      end

      it "return nil if no winning combination" do
        input =  [[ 0,  0,  0,  0,  0,  0,  0]]
        input << [ 0,  0,  0,  0,  0,  0,  0]
        input << [ 0,  0,  0,  0,  0,  1,  0]
        input << [ 0,  0,  1,  0, -1, -1,  0]
        input << [ 0,  1,  1, -1, -1,  1,  0]
        input << [ 1,  1, -1, -1,  1,  1,  1]
        expect(test.check_win(input)).to be_nil
      end
    end

    context "When there is a winning combination" do
      it "return RED if four POSITIVE ones are connected" do
        input =  [[ 0,  0,  0,  0,  0,  0,  0]]
        input << [ 0,  0,  0,  0,  0,  0,  0]
        input << [ 0,  0,  0,  0,  0,  0,  0]
        input << [ 0,  0,  0,  0,  0,  0,  0]
        input << [ 0,  0,  0,  0,  0,  0,  0]
        input << [ 0,  1,  1,  1,  1,  0,  0]
        expect(test.check_win(input)).to eql('RED')
      end

      it "return BLUE if four NEGATIVE ones are connected" do
        input =  [[ 0,  0,  0,  0,  0,  0,  0]]
        input << [ 0,  0,  0,  0,  0,  0,  0]
        input << [ 0,  -1,  0,  0,  0,  0,  0]
        input << [ 0,  0,  -1,  0,  0,  0,  0]
        input << [ 0,  0,  0,  -1,  0,  0,  0]
        input << [ 0,  0,  0,  0,  -1,  0,  0]
        expect(test.check_win(input)).to eql('BLUE')
      end

      it "return the winning color if a winner is found" do
      input = [
        [ 0,  0,  0,  0,  0,  0,  0],
        [ 0,  0,  0,  0,  0,  0,  0],
        [ 0, -1,  0,  0,  0,  0,  0],
        [ 0,  1, -1,  0,  0,  0,  0],
        [ 0,  1,  1, -1,  0,  0,  0],
        [ 0,  1, -1,  1, -1,  0,  0]
      ]
      expect(test.check_win(input)).to eql("BLUE")
      end

      it "return the winning color if a winner is found, even if the board is full" do
        result_input =  [[ 1, -1,  1, -1,  1, -1,  1]] # Row 1 (Top)
        result_input << [-1,  1, -1,  1, -1,  1, -1] # Row 2
        result_input << [ 1, -1,  1, -1,  1, -1,  1] # Row 3 (Red win starts here)
        result_input << [ 1,  1, -1,  1, -1,  1, -1] # Row 4
        result_input << [ 1, -1,  1, -1,  1, -1,  1] # Row 5
        result_input << [ 1,  1, -1,  1, -1,  1, -1] # Row 6 (Bottom - Red win ends)
      expect(test.check_win(result_input)).to eql("RED")
      end
    end
  end

  describe '#check_tie' do
    context "Returns false" do
      it "when board is empty" do
        result_input = Array.new(6) { Array.new(7, 0) }
        expect(test.check_tie(result_input)).to eql(false)
      end

      it "when board is partially full" do
        result_input = [[ 0, -1,  0, -1,  1, -1,  0]]
        result_input << [ 1, -1,  1, -1,  1, -1,  1]
        result_input << [ 1, -1,  1, -1,  1, -1,  1]
        result_input << [-1,  1, -1,  1, -1,  1, -1]
        result_input << [-1,  1, -1,  1, -1,  1, -1]
        result_input << [-1,  1, -1,  1, -1,  1, -1]
        expect(test.check_tie(result_input)).to eql(false)
      end

      it "when board is full but there is actually a winner" do
        result_input =  [[ 1, -1,  1, -1,  1, -1,  1]] # Row 1 (Top)
        result_input << [-1,  1, -1,  1, -1,  1, -1] # Row 2
        result_input << [ 1, -1,  1, -1,  1, -1,  1] # Row 3 (Red win starts here)
        result_input << [ 1,  1, -1,  1, -1,  1, -1] # Row 4
        result_input << [ 1, -1,  1, -1,  1, -1,  1] # Row 5
        result_input << [ 1,  1, -1,  1, -1,  1, -1] # Row 6 (Bottom - Red win ends)
        expect(test.check_tie(result_input)).to eql(false)
      end
    end

    context "Returns true" do
      it "When board is full but has no winning combination (test 1)" do
        result_input = [[ 1, -1,  1, -1,  1, -1,  1]]
        result_input << [ 1, -1,  1, -1,  1, -1,  1]
        result_input << [ 1, -1,  1, -1,  1, -1,  1]
        result_input << [-1,  1, -1,  1, -1,  1, -1]
        result_input << [-1,  1, -1,  1, -1,  1, -1]
        result_input << [-1,  1, -1,  1, -1,  1, -1]
        expect(test.check_tie(result_input)).to eql(true)
      end

      it "When board is full but has no winning combination (test 2)" do
        result_input =  [[ 1,  1, -1, -1,  1,  1, -1]]
        result_input << [-1, -1,  1,  1, -1, -1,  1]
        result_input << [ 1,  1, -1, -1,  1,  1, -1]
        result_input << [-1, -1,  1,  1, -1, -1,  1]
        result_input << [ 1,  1, -1, -1,  1,  1, -1]
        result_input << [-1, -1,  1,  1, -1, -1,  1]
        expect(test.check_tie(result_input)).to eql(true)
      end
    end
  end

  describe '#per_input_check' do

    context "When a specific index has a winning combination" do
      it "return TRUE if horizontal to the right combination is present" do
        result_input = [[0, 0, 0, 0, 0, 0, 0]]
        result_input << [0, 0, 0, 0, 0, 0, 0]
        result_input << [0, 0, 0, 0, 0, 0, 0]
        result_input << [0, 0, 0, 0, 0, 0, 0]
        result_input << [0, 0, 0, 0, 0, 0, 0]
        result_input << [0, 0, 1, 1, 1, 1, 0]
        expect(test.send(:per_input_check, 1, 5, 2, result_input)).to eql(true)
      end

      it "return TRUE if vertical downward combination is present" do
        result_input = [[0, 0, 0, -1, 0, 0, 0]]
        result_input << [0, 0, 0, -1, 0, 0, 0]
        result_input << [0, 0, 0, -1, 0, 0, 0]
        result_input << [0, 0, 0, -1, 0, 0, 0]
        result_input << [0, 0, 0, 0, 0, 0, 0]
        result_input << [0, 0, 0, 0, 0, 0, 0]
        expect(test.send(:per_input_check, -1, 0, 3, result_input)).to eql(true)
      end

      it "return TRUE if diagonal to upper-right combination is present" do
        result_input = [[0, 0, 0, 0, 0, 0, 0]]
        result_input << [0, 0, 0, 0, 0, 0, 0]
        result_input << [0, 0, 0, -1, 0, 0, 0]
        result_input << [0, 0, -1, 0, 0, 0, 0]
        result_input << [0, -1, 0, 0, 0, 0, 0]
        result_input << [-1, 0, 0, 0, 0, 0, 0]
        expect(test.send(:per_input_check, -1, 5, 0, result_input)).to eql(true)
      end

      it "return TRUE if diagonal to upper-left combination is present" do
        result_input = [[0, 0, 0, 0, 0, 0, 0]]
        result_input << [1, 0, 0, 0, 0, 0, 0]
        result_input << [0, 1, 0, 0, 0, 0, 0]
        result_input << [0, 0, 1, 0, 0, 0, 0]
        result_input << [0, 0, 0, 1, 0, 0, 0]
        result_input << [0, 0, 0, 0, 0, 0, 0]
        expect(test.send(:per_input_check, 1, 4, 3, result_input)).to eql(true)
      end
    end

    context "When a specific index has NO winning combination" do
      let(:input)  { [
        [ 0,  0,  0,  0,  0,  0,  0],
        [ 0,  0,  0,  0,  0,  0,  0],
        [ 0, -1,  0,  0,  0,  0,  0],
        [ 0,  1, -1,  0,  0,  0,  0],
        [ 0,  1,  1, -1,  0,  0,  0],
        [ 0,  1, -1,  1, -1,  0,  0]
      ] }

      it "return FALSE (test 1)" do
        expect(test.send(:per_input_check, 1, 4, 3, input)).to eql(false)
      end

      it "return FALSE (test 2)" do
        expect(test.send(:per_input_check, -1, 2, 1, input)).to eql(false)
      end

      it "return FALSE if input is ZERO" do
        expect(test.send(:per_input_check, 0, 0, 0, input)).to eql(false)
      end
      
    end
  end
end