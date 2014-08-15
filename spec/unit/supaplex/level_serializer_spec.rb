require "spec_helper"
require "stringio"

describe Supaplex::LevelSerializer do
  describe "#read_level_from" do
    let(:io) { fixture("test_level.sp", :binary) }

    it "reads and deserializes level from given io" do
      level = subject.read_level_from(io)

      expect(level).to be_instance_of(Supaplex::Level)

      expect(level.fields[2][1]).to eq 3 # murphy
      expect(level.fields[3][1]).to eq 7 # exit

      expect(level.name).to eq "--TEST LEVEL-----------"
      expect(level.gravity).to be true
      expect(level.freeze_zonks).to be false
      expect(level.infotrons_needed).to eq 13

      expect(level.fields[1][2]).to eq 13 # PORT_RIGHT_G
      expect(level.fields[1][3]).to eq 15 # PORT_LEFT_G
      expect(level.special_ports.size).to eq 2

      expect(level.special_ports[0].y).to eq 1
      expect(level.special_ports[0].x).to eq 2
      expect(level.special_ports[0].gravity).to be true
      expect(level.special_ports[0].freeze_zonks).to be false
      expect(level.special_ports[0].freeze_enemy).to be true
    end
  end

  describe "#write_level_to" do
    let!(:level_binary)     { fixture("test_level.sp", :binary) } # ! to enforce fixture creation outside FakeFS block
    let(:level)             { subject.read_level_from(StringIO.new(level_binary).set_encoding("binary")) }
    let(:io)                { StringIO.new.set_encoding("binary") }
    let(:serialized_binary) { io.rewind; io.read }

    before do
      subject.write_level_to(level, io)
    end

    it "serializes fields bytes" do
      expect(serialized_binary[0, 1440]).to eq level_binary[0, 1440]
    end

    it "serializes gravity byte" do
      expect(serialized_binary[1444]).to eq level_binary[1444]
    end

    it "serializes title bytes" do
      expect(serialized_binary[1446, 23]).to eq level_binary[1446, 23]
    end

    it "serializes freeze zonks byte" do
      expect(serialized_binary[1469]).to eq level_binary[1469]
    end

    it "serializes infotron needed byte" do
      expect(serialized_binary[1470]).to eq level_binary[1470]
    end

    it "serializes special ports count byte" do
      expect(serialized_binary[1471]).to eq level_binary[1471]
    end

    it "serializes special ports bytes" do
      # 2 special ports, each 6 bytes = 12 total bytes
      expect(serialized_binary[1472, 12]).to eq level_binary[1472, 12]
    end
  end
end

