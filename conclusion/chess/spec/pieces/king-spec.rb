 require_relative '../../lib/pieces/king'

 describe King do
  let(:start_pos) { [5, 5] }
  let(:positions) { nil }
  let(:color) { 'white' }
  subject(:king) { described_class.new(color, start_pos, positions) }

  describe "#move" do
    context "When input is invalid" do
      it "return INVALID when move is not in its perimeter" do
        expect(king.move([7, 5])).to eq("INVALID")
      end
    end

    context "When input is invalid" do
      let(:start_pos) { [7, 0] }
      it "return INVALID when move valid but outside board boundary" do
        expect(king.move([8, 1])).to eq("INVALID")
      end
    end

    context "When neighbor is of same color" do
      let(:positions) { { [6, 5] => {color: 'white', piece: 'pawn'} } }
      it "returns INVALID when moved at the neighbor with same color" do
        expect(king.move([6, 5])).to eq("INVALID")
      end
    end

    context "When neighbor is of opposite color" do
      let(:positions) { { [6, 5] => {color: 'black', piece: 'pawn'} } }
      it "returns VALID when king takes neighboring enemy" do
        expect(king.move([6, 5])).to eq("VALID")
      end
    end

    context "When neighbor is of opposite color, but protected" do
      let(:positions) { { [4, 4] => {color: 'black', piece: 'pawn'}, [2, 5] => {color: 'black', piece: 'knight'}} }
      it "returns INVALID when king tried to take protected piece" do
        expect(king.move([4, 4])).to eq("INVALID")
      end
    end

    context "When neighbor is empty, but being attacked" do
      let(:positions) {
        { [4, 4] => {color: 'black', piece: 'pawn'},
          [6, 2] => {color: 'black', piece: 'rook'},
          [3, 2] => {color: 'black', piece: 'knight'},
          [7, 6] => {color: 'black', piece: 'bishop'},
          [3, 6] => {color: 'black', piece: 'queen'},
          [0, 0] => {color: 'white', piece: 'queen'} } 
      }

      it "returns INVALID when moved up (attacked by queen)" do
        expect(king.move([4, 5])).to eq("INVALID")
      end

      it "returns INVALID when moved up-right (attacked by queen)" do
        expect(king.move([4, 6])).to eq("INVALID")
      end

      it "returns INVALID when moved right (attacked by queen)" do
        expect(king.move([5, 6])).to eq("INVALID")
      end

      it "returns INVALID when moved down-right (attacked by queen)" do
        expect(king.move([6, 6])).to eq("INVALID")
      end

      it "returns INVALID when moved down (attacked by bishop and rook)" do
        expect(king.move([6, 5])).to eq("INVALID")
      end

      it "returns INVALID when moved down-left (attacked by rook)" do
        expect(king.move([6, 4])).to eq("INVALID")
      end

      it "returns INVALID when moved left (attacked by queen)" do
        expect(king.move([5, 4])).to eq("INVALID")
      end

      it "returns INVALID when moved up-left (tries to take pawn but protected by knight)" do
        expect(king.move([4, 4])).to eq("INVALID")
      end
    end

    context "When neighbor is empty, and not being attacked" do
      it "return VALID when moving up" do
        expect(king.move([4, 5])).to eq("VALID")
      end

      it "return VALID when moving up-right" do
        expect(king.move([4, 6])).to eq("VALID")
      end

      it "return VALID when moving right" do
        expect(king.move([5, 6])).to eq("VALID")
      end

      it "return VALID when moving down-right" do
        expect(king.move([6, 6])).to eq("VALID")
      end

      it "return VALID when moving down" do
        expect(king.move([6, 5])).to eq("VALID")
      end

      it "return VALID when moving down-left" do
        expect(king.move([6, 4])).to eq("VALID")
      end

      it "return VALID when moving left" do
        expect(king.move([5, 4])).to eq("VALID")
      end

      it "return VALID when moving up-left" do
        expect(king.move([4, 4])).to eq("VALID")
      end
    end
  end

  describe "#is_check?" do
    context "When king is currently attacked by enemy pawn" do
      let(:positions) { {[4, 4] => {color: 'black', piece: 'pawn', moves: 0}, [5, 5] => {color: 'white', piece: 'king'}} }
      it "return TRUE" do
        expect(king.is_check?).to eq(true)
      end
    end

    context "When king is currently attacked by enemy knight" do
      let(:positions) { {[4, 7] => {color: 'black', piece: 'knight'}} }
      it "return TRUE" do
        expect(king.is_check?).to eq(true)
      end
    end

    context "When king is currently attacked by enemy bishop" do
      let(:positions) { {[0, 0] => {color: 'black', piece: 'bishop'}} }
      it "return TRUE" do
        expect(king.is_check?).to eq(true)
      end
    end

    context "When king is currently attacked by enemy rook" do
      let(:positions) { {[0, 5] => {color: 'black', piece: 'rook'}} }
      it "return TRUE" do
        expect(king.is_check?).to eq(true)
      end
    end

    context "When king is currently attacked by enemy queen" do
      let(:positions) { {[5, 0] => {color: 'black', piece: 'queen'}} }
      it "return TRUE" do
        expect(king.is_check?).to eq(true)
      end
    end
  end

  describe "#is_checkmate?" do
    context "When king cannot move but not yet checked" do
      let(:positions) {
        { 
          [5, 5] => {color: 'white', piece: 'king'},
          [4, 4] => {color: 'black', piece: 'pawn'},
          [6, 2] => {color: 'black', piece: 'rook'},
          [7, 6] => {color: 'black', piece: 'bishop'},
          [3, 6] => {color: 'black', piece: 'queen'} }
      }
      it "returns false" do
        expect(king.is_checkmate?).to be false
      end
    end

    context "When king cannot move and is checked" do
      let(:positions) {
        { 
          [5, 5] => {color: 'white', piece: 'king'},   # Current King
          [4, 4] => {color: 'black', piece: 'pawn'},   # Controls [5,3] & [3,5]
          [6, 2] => {color: 'black', piece: 'rook'},   # Controls 6th rank
          [3, 2] => {color: 'black', piece: 'knight'}, # Controls [5,3] etc
          [7, 6] => {color: 'black', piece: 'bishop'}, # Diagonal control
          [3, 6] => {color: 'black', piece: 'queen'},  # Multi-directional
          [0, 5] => {color: 'black', piece: 'rook'}    # The piece putting King in check
        }
      }
      it "returns true" do
        expect(king.is_checkmate?).to be true
      end
    end

    context "When black checkmates white" do
      let(:start_pos) { [7, 4] }
      let(:color) { 'white' }
      let(:positions) { {
        [7, 4] => {color: 'white', piece: 'king', moves: 0, active: false}, # e1
        # Block White King's escape routes
        [7, 3] => {color: 'white', piece: 'queen', active: false},         # d1 blocked
        [7, 5] => {color: 'white', piece: 'bishop', active: false},        # f1 blocked
        [6, 4] => {color: 'white', piece: 'pawn', active: false},          # e2 blocked
        [6, 3] => {color: 'white', piece: 'pawn', active: false},          # d2 blocked
        
        # The pawns that cause the Fool's Mate
        [5, 5] => {color: 'white', piece: 'pawn', moves: 1, active: false}, # f3 moved
        [4, 6] => {color: 'white', piece: 'pawn', moves: 1, active: false}, # g4 moved
        
        # Black Queen delivering the killing blow
        [4, 7] => {color: 'black', piece: 'queen', moves: 1, active: true}, # Qh4#
        [0, 4] => {color: 'black', piece: 'king', moves: 0, active: false}
      } }
      it "returns true" do
        expect(king.is_checkmate?).to eq(true)
      end
    end

    context "when black almost checkmates white but ally can capture the checking piece" do
      let(:start_pos) { [7, 4] }
      let(:color) { 'white' }
      let(:positions) {{
        [7, 4] => {color: 'white', piece: 'king', moves: 0, active: false}, # e1
        # Block White King's escape routes
        [7, 3] => {color: 'white', piece: 'queen', active: false},         # d1 blocked
        [7, 5] => {color: 'white', piece: 'bishop', active: false},        # f1 blocked
        [6, 4] => {color: 'white', piece: 'pawn', active: false},          # e2 blocked
        [6, 3] => {color: 'white', piece: 'pawn', active: false},          # d2 blocked
        
        # The pawns that cause the Fool's Mate
        [5, 5] => {color: 'white', piece: 'pawn', moves: 1, active: false}, # f3 moved
        [4, 6] => {color: 'white', piece: 'pawn', moves: 1, active: false}, # g4 moved
        
        # Black Queen delivering the killing blow (almost)
        [4, 7] => {color: 'black', piece: 'queen', moves: 1, active: true}, # Qh4+
        [0, 4] => {color: 'black', piece: 'king', moves: 0, active: false},

        #White Rook can take the Queen, eliminating the checkmate threat
        [7, 7] => {color: 'white', piece: 'rook', moves: 0, active: false}
      } }

      it "returns false" do
        expect(king.is_checkmate?).to eq(false)
      end
    end
  end

  describe "#castle_valid?" do
    context "When White is castling" do
      let(:color) { 'white' }
      let(:start_pos) { [7, 4] } # e1

      context "King-side (O-O)" do
        let(:target) { [7, 6] } # g1

        it "returns true when path is clear and pieces haven't moved" do
          positions = {
            [7, 4] => {piece: 'king', color: 'white', moves: 0, active: false},
            [7, 7] => {piece: 'rook', color: 'white', moves: 0, active: false}
          }
          expect(King.new(color, start_pos, positions).castle_valid?(target)).to be true
        end

        it "returns false if the f1 square is occupied" do
          positions = {
            [7, 4] => {piece: 'king', color: 'white', moves: 0, active: false},
            [7, 5] => {piece: 'bishop', color: 'white', moves: 0, active: false},
            [7, 7] => {piece: 'rook', color: 'white', moves: 0, active: false}
          }
          expect(King.new(color, start_pos, positions).castle_valid?(target)).to be false
        end

        it "returns false if the King is in check" do
          positions = {
            [7, 4] => {piece: 'king', color: 'white', moves: 0, active: false},
            [7, 7] => {piece: 'rook', color: 'white', moves: 0, active: false},
            [0, 4] => {piece: 'rook', color: 'black', moves: 0, active: false}
          }
          expect(King.new(color, start_pos, positions).castle_valid?(target)).to be false
        end
      end

      context "Queen-side (O-O-O)" do
        let(:target) { [7, 2] } # c1

        it "returns true when path (b1, c1, d1) is clear" do
          positions = {
            [7, 4] => {piece: 'king', color: 'white', moves: 0, active: false},
            [7, 0] => {piece: 'rook', color: 'white', moves: 0, active: false}
          }
          expect(King.new(color, start_pos, positions).castle_valid?(target)).to be true
        end

        it "returns false if the King passes through check at d1" do
          positions = {
            [7, 4] => {piece: 'king', color: 'white', moves: 0, active: false},
            [7, 0] => {piece: 'rook', color: 'white', moves: 0, active: false},
            [0, 3] => {piece: 'rook', color: 'black', moves: 0, active: false} # Attacks d1
          }
          expect(King.new(color, start_pos, positions).castle_valid?(target)).to be false
        end

        it "returns true even if the Rook's path at b1 is under attack" do
          positions = {
            [7, 4] => {piece: 'king', color: 'white', moves: 0, active: false},
            [7, 0] => {piece: 'rook', color: 'white', moves: 0, active: false},
            [0, 1] => {piece: 'rook', color: 'black', moves: 0, active: false} # Attacks b1
          }
          expect(King.new(color, start_pos, positions).castle_valid?(target)).to be true
        end
      end
    end

    context "When Black is castling" do
      let(:color) { 'black' }
      let(:start_pos) { [0, 4] } # e8

      it "returns true for a valid black King-side castle (g8)" do
        positions = {
          [0, 4] => {piece: 'king', color: 'black', moves: 0, active: false},
          [0, 7] => {piece: 'rook', color: 'black', moves: 0, active: false}
        }
        expect(King.new(color, start_pos, positions).castle_valid?([0, 6])).to be true
      end

      it "returns true for a valid black Queen-side castle (c8)" do
        positions = {
          [0, 4] => {piece: 'king', color: 'black', moves: 0, active: false},
          [0, 0] => {piece: 'rook', color: 'black', moves: 0, active: false}
        }
        expect(King.new(color, start_pos, positions).castle_valid?([0, 2])).to be true
      end

      it "returns false if the Rook has already moved" do
        positions = {
          [0, 4] => {piece: 'king', color: 'black', moves: 0, active: false},
          [0, 7] => {piece: 'rook', color: 'black', moves: 1, active: false}
        }
        expect(King.new(color, start_pos, positions).castle_valid?([0, 6])).to be false
      end
    end
  end
 end