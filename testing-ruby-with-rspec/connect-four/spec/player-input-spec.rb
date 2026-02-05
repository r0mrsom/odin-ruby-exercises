require_relative '../lib/player-input'

describe PlayerInput do
  subject(:test) { described_class.new }

  describe '#place' do
    context 'when there is no input' do
      it 'returns the default empty grid' do
        expect(test.place).to eq(Array.new(6) { Array.new(7, 0) })
      end
    end

    context 'when there is input' do
      it 'returns a new array with column input at the bottom' do
        input = 1
        column = 5
        expected = Array.new(5) { Array.new(7, 0) } << [0, 0, 0, 0, 1, 0, 0]
        expect(test.place(input, column)).to eq(expected)
      end

      it 'stacks multiple inputs in the same column' do
        test.place(1, 5)
        second_placement = test.place(1, 5)
        
        expected = Array.new(4) { Array.new(7, 0) }
        expected << [0, 0, 0, 0, 1, 0, 0]
        expected << [0, 0, 0, 0, 1, 0, 0]
        
        expect(second_placement).to eq(expected)
      end

      it 'respects the column height limit (returns "FULL")' do
        5.times { test.place(-1, 5) }
        test.place(1, 5)
        
        full_grid = Array.new(5) {[0, 0, 0, 0, -1, 0, 0]} 
        full_grid.unshift([0, 0, 0, 0, 1, 0, 0])
        
        final_input = test.place(1, 5)
        
        expect(final_input).to eq("FULL")
      end

      it 'correctly stacks inputs across different columns' do
        test.place(1, 5)
        test.place(-1, 2)
        test.place(-1, 4)
        test.place(1, 5)
        test.place(-1, 5)
        
        final_result = test.place(1, 6)
        
        expected = Array.new(3) { Array.new(7, 0) }
        expected << [0, 0, 0, 0, -1, 0, 0]
        expected << [0, 0, 0, 0, 1, 0, 0]
        expected << [0, -1, 0, -1, 1, 1, 0]
        
        expect(final_result).to eq(expected)
      end
    end
  end
end