require_relative '../lib/game'

describe Gameplay do
  let(:player_manager_double) { instance_double("PlayerInput") }
  subject(:test_game) { described_class.new }

  before do
    allow(PlayerInput).to receive(:new).and_return(player_manager_double)
    
    allow(player_manager_double).to receive(:input=)
    allow(player_manager_double).to receive(:result=)
    allow(player_manager_double).to receive(:column=)
    allow(player_manager_double).to receive(:input).and_return(1)

    allow(test_game).to receive(:display)
    allow(test_game).to receive(:prompt)
    allow(test_game).to receive(:puts)
    allow(test_game).to receive(:system)
  end

  describe "#initialize" do
    it "creates a 6x7 nested array of zeros" do
      expect(test_game.result).to eq(Array.new(6) { Array.new(7, 0) })
    end
  end

  describe "#game" do
    context "when playing a simple turn" do
      it "breaks the loop when place returns the result array" do
        allow(test_game).to receive(:column_input).and_return("4")
        allow(Logic).to receive(:check_win).and_return(false, true)
        allow(Logic).to receive(:check_tie).and_return(false)

        expect(player_manager_double).to receive(:place).and_return(test_game.result)
        
        test_game.game
      end
    end

    context "when column is full" do
      it "displays the FULL error message and retries" do
        allow(test_game).to receive(:column_input).and_return("1", "2")
        allow(Logic).to receive(:check_win).and_return(false, true)
        allow(Logic).to receive(:check_tie).and_return(false)

        allow(player_manager_double).to receive(:place).and_return("FULL", test_game.result)

        expect(test_game).to receive(:prompt).with(/is FULL/)
        test_game.game
      end
    end

    context "when input is out of range" do
      it "displays the invalid input message" do
        allow(test_game).to receive(:column_input).and_return("9", "1")
        allow(Logic).to receive(:check_win).and_return(false, true)
        allow(Logic).to receive(:check_tie).and_return(false)
        allow(player_manager_double).to receive(:place).and_return(test_game.result)

        expect(test_game).to receive(:prompt).with(/Invalid input/)
        test_game.game
      end
    end
  end

  describe ".start" do
    it "instantiates the class and runs the game" do
      instance = instance_double(Gameplay)
      allow(Gameplay).to receive(:new).and_return(instance)
      
      expect(instance).to receive(:game)
      Gameplay.start
    end
  end
end