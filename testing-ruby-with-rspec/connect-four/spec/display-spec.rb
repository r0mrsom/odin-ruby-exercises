require_relative '../lib/display'

#This spec document tests the connect four board, ensuring that colors are correct at correct input

describe Display do
  describe '#print' do
    #Fresh start, if all inputs are zero, all colors are gray
    context 'When fresh start game' do
      let(:input) {Array.new(6, Array.new(7, 0))}
      subject(:screen) { described_class.new(input) }
      it 'Displays a 7 x 6 grid' do
        expected_output = <<~GRID.chomp
          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .
        GRID
        formatted_output = expected_output.gsub('.', "\e[100m    \e[0m")
        expect(screen.print).to eq(formatted_output)
      end
    end

    #If all inputs are +1, all colors are red
    context 'When there are inputs' do
      let(:input2) {Array.new(6, Array.new(7, 1))}
      subject(:screen2) { Display.new(input2) }
      it 'Displays a 7 x 6 grid with all red' do
        expected_output2 = <<~GRID.chomp
          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .
        GRID
        formatted_output2 = expected_output2.gsub('.', "\e[101m    \e[0m")
        expect(screen2.print).to eq(formatted_output2)
      end

      #If all inputs are -1, all colors are red
      let(:input3) {Array.new(6, Array.new(7, -1))}
      subject(:screen3) { Display.new(input3) }
      it 'Displays a 7 x 6 grid with all blue' do
        expected_output3 = <<~GRID.chomp
          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .
        GRID
        formatted_output3 = expected_output3.gsub('.', "\e[104m    \e[0m")
        expect(screen3.print).to eq(formatted_output3)
      end

      #Color should reflect based on the input; (0) -> gray, (+1) -> red, (-1) -> blue
      let(:input4) {[[0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0],
                    [0, 1, 0, -1, 0, -1, 0],
                    [1, 0, -1, 0, 1, 0, -1]]}
      subject(:screen4) { Display.new(input4) }
      it 'Displays a 7 x 6 grid with correct colors' do
        expected_output4 = <<~GRID.chomp
          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  .  .  .  .  .  .

          .  \e[101m    \e[0m  .  \e[104m    \e[0m  .  \e[104m    \e[0m  .

          \e[101m    \e[0m  .  \e[104m    \e[0m  .  \e[101m    \e[0m  .  \e[104m    \e[0m
        GRID
        formatted_output4 = expected_output4.gsub('.', "\e[100m    \e[0m")
        expect(screen4.print).to eq(formatted_output4)
      end
      
    end
  end
end