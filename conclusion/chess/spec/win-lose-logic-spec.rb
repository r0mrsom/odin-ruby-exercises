require_relative '../lib/win-lose-logic'

describe WinOrLose do
  let(:starting_positions) { {
      [0, 0] => {color: 'black', piece: 'rook', moves: 0, active: false},
      [0, 1] => {color: 'black', piece: 'knight', active: false},
      [0, 2] => {color: 'black', piece: 'bishop', active: false},
      [0, 3] => {color: 'black', piece: 'queen', active: false},
      [0, 4] => {color: 'black', piece: 'king', moves: 0, active: false},
      [0, 5] => {color: 'black', piece: 'bishop', active: false},
      [0, 6] => {color: 'black', piece: 'knight', active: false},
      [0, 7] => {color: 'black', piece: 'rook', moves: 0, active: false},
      [1, 0] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 1] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 2] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 3] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 4] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 5] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 6] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 7] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [6, 0] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 1] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 2] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 3] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 4] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 5] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 6] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 7] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [7, 0] => {color: 'white', piece: 'rook', moves: 0, active: false},
      [7, 1] => {color: 'white', piece: 'knight', active: false},
      [7, 2] => {color: 'white', piece: 'bishop', active: false},
      [7, 3] => {color: 'white', piece: 'queen', active: false},
      [7, 4] => {color: 'white', piece: 'king', moves: 0, active: false},
      [7, 5] => {color: 'white', piece: 'bishop', active: false},
      [7, 6] => {color: 'white', piece: 'knight', active: false},
      [7, 7] => {color: 'white', piece: 'rook', moves: 0, active: false}, 
  } }

  describe "#win?" do
    context "When at starting position," do
      it "returns false" do
        expect(WinOrLose.new(starting_positions, 1).win?).to eql(false)
      end
    end

    context "When white checkmates black (Scholar's Mate)" do
      let(:mate_positions) { {
        [0, 4] => {color: 'black', piece: 'king', moves: 0, active: false},
        [0, 3] => {color: 'black', piece: 'queen', active: false},
        [0, 5] => {color: 'black', piece: 'bishop', active: false},
        [1, 3] => {color: 'black', piece: 'pawn', active: false},
        [1, 4] => {color: 'black', piece: 'pawn', active: false}, 
        [1, 5] => {color: 'white', piece: 'queen', moves: 3, active: true},
        [4, 2] => {color: 'white', piece: 'bishop', moves: 1, active: false},
        [7, 4] => {color: 'white', piece: 'king', moves: 0, active: false}
      } }

      it "returns TRUE when player is white" do
        expect(WinOrLose.new(mate_positions, 1).win?).to eq(true)
      end
    end

    context "When black checkmates white (Smothered Back-Rank)" do
      let(:back_rank_mate) { {
        [7, 4] => {color: 'white', piece: 'king', moves: 0, active: false},
        # Lateral escapes blocked by own pieces
        [7, 5] => {color: 'white', piece: 'bishop', active: false},
        [7, 6] => {color: 'white', piece: 'knight', active: false},
        # Forward escapes blocked by own pawns
        [6, 3] => {color: 'white', piece: 'pawn', active: false},
        [6, 4] => {color: 'white', piece: 'pawn', active: false},
        [6, 5] => {color: 'white', piece: 'pawn', active: false},
        # Attacker: Rook on a1 [7, 0]. Path [7,1-3] is empty.
        [7, 0] => {color: 'black', piece: 'rook', moves: 1, active: true}, 
        [0, 4] => {color: 'black', piece: 'king', moves: 0, active: false}
      } }

      it "returns TRUE when player is black" do
        expect(WinOrLose.new(back_rank_mate, -1).win?).to eq(true)
      end
    end
  end

  describe "#stalemate?" do
    context "When at starting position," do
      it "returns false for white" do
        expect(WinOrLose.new(starting_positions, 1).stalemate?).to eq(false)
      end

      it "returns false for black" do
        expect(WinOrLose.new(starting_positions, -1).stalemate?).to eq(false)
      end
    end

    context "When black stalemates white (Corner Trap)" do
      let(:stalemate_positions) { {
        [7, 7] => {color: 'white', piece: 'king', moves: 5, active: false},
        [6, 5] => {color: 'black', piece: 'queen', moves: 4, active: false},
        [5, 5] => {color: 'black', piece: 'king', moves: 6, active: false}
      } }

      it "returns true if player is white" do
        expect(WinOrLose.new(stalemate_positions, 1).stalemate?).to eq(true)
      end

      it "returns false if player is black" do
        expect(WinOrLose.new(stalemate_positions, -1).stalemate?).to eq(false)
      end
    end
  end

  describe "Mid-Game validation" do
    let(:mid_game) { {
      [0, 4] => {color: 'black', piece: 'king', moves: 1, active: false},
      [7, 4] => {color: 'white', piece: 'king', moves: 0, active: false},
      [4, 4] => {color: 'white', piece: 'pawn', active: false},
      [3, 4] => {color: 'black', piece: 'pawn', active: false}
    } }

    it "returns false for win and stalemate" do
      game = WinOrLose.new(mid_game, 1)
      expect(game.win?).to eq(false)
      expect(game.stalemate?).to eq(false)
    end
  end
end