require_relative '../../lib/pieces/pawn'

describe Pawn do
  let(:start_pos) { [6, 4] }
  let(:color) { 'white' }
  let(:moves_count) { 0 }
  let(:positions) { nil }
  
  subject(:pawn) { described_class.new(color, start_pos, moves_count, positions) }

  describe "#move" do
    context "when Pawn is white" do
      it "returns INVALID for backward moves" do
        expect(pawn.move([7, 4])).to eq("INVALID")
      end

      it "returns INVALID for horizontal moves" do
        expect(pawn.move([6, 5])).to eq("INVALID")
      end

      context "at starting position (no prior moves)" do
        let(:moves_count) { 0 }
        
        it "returns VALID for moving two squares forward" do
          expect(pawn.move([4, 4])).to eq("VALID")
        end
      end

      context "after having moved already" do
        let(:moves_count) { 1 }

        it "returns INVALID for moving two squares forward" do
          expect(pawn.move([4, 4])).to eq("INVALID")
        end

        it "returns VALID for moving one square forward" do
          expect(pawn.move([5, 4])).to eq("VALID")
        end
      end
    end

    context "when dealing with obstructions as white (Forward Move)" do
      let(:start_pos) { [6, 4] }

      context "when an enemy piece is directly in front" do
        let(:positions) { { [5, 4] => { color: 'black', piece: 'rook' } } }
        
        it "returns INVALID (pawns cannot capture forward)" do
          expect(pawn.move([5, 4])).to eq("INVALID")
        end
      end

      context "when a teammate piece is directly in front" do
        let(:positions) { { [5, 4] => { color: 'white', piece: 'rook' } } }
        
        it "returns INVALID" do
          expect(pawn.move([5, 4])).to eq("INVALID")
        end
      end
    end

    context "when capturing diagonally as white" do
      let(:start_pos) { [6, 4] }
      let(:target_diag) { [5, 5] }

      context "when an enemy is on the diagonal square" do
        let(:positions) { { target_diag => { color: 'black', piece: 'knight' } } }
        
        it "returns VALID" do
          expect(pawn.move(target_diag)).to eq("VALID")
        end
      end

      context "when a teammate is on the diagonal square" do
        let(:positions) { { target_diag => { color: 'white', piece: 'knight' } } }
        
        it "returns INVALID" do
          expect(pawn.move(target_diag)).to eq("INVALID")
        end
      end

      context "when the diagonal square is empty" do
        let(:positions) { {} }
        
        it "returns INVALID (pawns only move diagonally to capture)" do
          expect(pawn.move(target_diag)).to eq("INVALID")
        end
      end
    end

    context "when Pawn is black" do
      let(:color) { 'black' }
      let(:start_pos) { [1, 4] }

      it "returns INVALID for moving up one square" do
        expect(pawn.move([0, 4])).to eq("INVALID")
      end

      it "returns INVALID for moving horizontal" do
        expect(pawn.move([1, 5])).to eq("INVALID")
      end

      it "returns VALID for moving down one square" do
        expect(pawn.move([2, 4])).to eq("VALID")
      end

      context "at starting position (no prior moves)" do
        let(:moves_count) { 0 }
        
        it "returns VALID for moving two squares forward" do
          expect(pawn.move([3, 4])).to eq("VALID")
        end
      end

      context "after having moved already" do
        let(:moves_count) { 1 }

        it "returns INVALID for moving two squares forward" do
          expect(pawn.move([3, 4])).to eq("INVALID")
        end

        it "returns VALID for moving one square forward" do
          expect(pawn.move([2, 4])).to eq("VALID")
        end
      end
    end

    context "when dealing with obstructions as black (Forward Move)" do
      let(:color) { 'black' }
      let(:start_pos) { [5, 4] }

      context "when an enemy piece is directly in front" do
        let(:positions) { { [6, 4] => { color: 'white', piece: 'rook' } } }
        
        it "returns INVALID (pawns cannot capture forward)" do
          expect(pawn.move([6, 4])).to eq("INVALID")
        end
      end

      context "when a teammate piece is directly in front" do
        let(:positions) { { [6, 4] => { color: 'black', piece: 'rook' } } }
        
        it "returns INVALID" do
          expect(pawn.move([6, 4])).to eq("INVALID")
        end
      end
    end

    context "when capturing diagonally as black" do
      let(:start_pos) { [5, 4] }
      let(:target_diag) { [6, 5] }
      let(:color) { 'black' }

      context "when an enemy is on the diagonal square" do
        let(:positions) { { target_diag => { color: 'white', piece: 'knight' } } }
        
        it "returns VALID" do
          expect(pawn.move(target_diag)).to eq("VALID")
        end
      end

      context "when a teammate is on the diagonal square" do
        let(:positions) { { target_diag => { color: 'black', piece: 'knight' } } }
        
        it "returns INVALID" do
          expect(pawn.move(target_diag)).to eq("INVALID")
        end
      end

      context "when the diagonal square is empty" do
        let(:positions) { {} }
        
        it "returns INVALID (pawns only move diagonally to capture)" do
          expect(pawn.move(target_diag)).to eq("INVALID")
        end
      end
    end

    context "when taking via en-passant" do
      let(:color) { 'white' }
      let(:start_pos) { [3, 4] } # 5th rank for White (Row 3)
      let(:target_diag) { [2, 5] }
      
      context "as white" do
        it "returns VALID when the enemy pawn is adjacent, active, and has one move" do
          # The victim pawn must be active (meaning it just moved)
          positions = { 
            [3, 5] => { color: 'black', piece: 'pawn', moves: 1, active: true } 
          }
          pawn = described_class.new(color, start_pos, 1, positions)
          expect(pawn.move(target_diag)).to eq("VALID")
        end

        it "returns INVALID if the adjacent pawn is NOT active (not the last move)" do
          # Even if moves is 1, if active is false, another move happened since then
          positions = { 
            [3, 5] => { color: 'black', piece: 'pawn', moves: 1, active: false } 
          }
          pawn = described_class.new(color, start_pos, 1, positions)
          expect(pawn.move(target_diag)).to eq("INVALID")
        end

        it "returns INVALID if the adjacent pawn is active but has more than 1 move" do
          # This prevents en-passant on pawns that just moved one square normally
          positions = { 
            [3, 5] => { color: 'black', piece: 'pawn', moves: 2, active: true } 
          }
          pawn = described_class.new(color, start_pos, 2, positions)
          expect(pawn.move(target_diag)).to eq("INVALID")
        end
      end

      context "as black" do
        let(:color) { 'black' }
        let(:start_pos) { [4, 2] } # 4th rank (Row 4)
        let(:target_diag) { [5, 3] }

        it "returns VALID when the white pawn just jumped to the adjacent square" do
          positions = { 
            [4, 3] => { color: 'white', piece: 'pawn', moves: 1, active: true } 
          }
          pawn = described_class.new(color, start_pos, 1, positions)
          expect(pawn.move(target_diag)).to eq("VALID")
        end
      end
    end
  end
end