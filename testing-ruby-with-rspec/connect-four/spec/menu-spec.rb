require_relative '../lib/menu'

describe Menu do
  subject(:menu) { described_class.new }

  before do
    allow(menu).to receive(:system)
    allow(menu).to receive(:puts)
    allow(menu).to receive(:print)
    allow(STDIN).to receive(:getch)
  end

  describe '#home' do
    context "when user enters 'quit'" do
      it "calls endGame and breaks the loop" do
        allow(menu).to receive(:gets).and_return("quit")
        
        expect(menu).to receive(:endGame).once
        menu.home
      end
    end

    context "when user enters 'tutorial' then 'quit'" do
      it "calls tutorial and then endGame" do
        allow(menu).to receive(:gets).and_return("tutorial", "quit")
        
        expect(menu).to receive(:tutorial).once
        expect(menu).to receive(:endGame).once
        menu.home
      end
    end

    context "when user enters 'start' then 'quit'" do
      it "starts the game and then ends when quit is entered" do
        allow(menu).to receive(:gets).and_return("start", "quit")
        allow(Gameplay).to receive(:start)

        expect(Gameplay).to receive(:start).once
        menu.home
      end
    end

    context "when user enters invalid inputs then 'quit'" do
      it "re-runs the loop (re-displays home) until quit is entered" do
        allow(menu).to receive(:gets).and_return("invalid_junk", "invalid_2", "quit")
        
        expect(menu).to receive(:home_display).exactly(3).times
        menu.home
      end
    end
  end

  describe '#returnHome' do
    it "waits for a keypress" do
      expect(STDIN).to receive(:getch)
      menu.returnHome
    end
  end
end