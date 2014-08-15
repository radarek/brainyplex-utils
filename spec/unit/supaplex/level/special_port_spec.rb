require "spec_helper"

describe Supaplex::Level::SpecialPort do
  subject { described_class.new }

  describe "initialize" do
    it "creates new special port and initialize itself with given values" do
      special_port = described_class.new(hi: 2, lo: 1, gravity: true, freeze_zonks: false, freeze_enemy: true)

      expect(special_port.lo).to eq 1
      expect(special_port.hi).to eq 2
      expect(special_port.gravity).to eq true
      expect(special_port.freeze_zonks).to eq false
      expect(special_port.freeze_enemy).to eq true
    end
  end

  describe "x, y getters" do
    before do
      subject.hi = 8
      subject.lo = 142
    end

    it "returns x and y coordinates calculated from lo and hi attributes" do
      expect(subject.x).to eq 15
      expect(subject.y).to eq 18
    end
  end
end

