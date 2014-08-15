require "spec_helper"

describe Supaplex::Level do
  let(:level) { subject }

  describe "special_ports attribute" do
    it "returns empty array by default" do
      expect(level.special_ports).to eq []
    end
  end

  describe "#add_special_port", broken: true do
    let(:special_port) { described_class::SpecialPort.new(lo: 1, hi: 2, gravity: true, freeze_zonks: false, freeze_enemy: true) }

    it "adds new special port to list of special ports" do
      expect { level.add_special_port(special_port) }.to change { level.special_ports.size }.by(1)
    end

    it "allows to add new ports up to 10 and raises error after that limit" do
      10.times { level.add_special_port(special_port) }

      expect { level.add_special_port(special_port) }.to raise_error
    end
  end

  describe "infotrons_needed attribute" do
    it "has value 0 by default" do
      expect(level.infotrons_needed).to eq 0
    end

    it "allows to change it to new numeric value" do
      level.infotrons_needed = 15
      expect(level.infotrons_needed).to eq 15
    end
  end

  describe "gravity attribute" do
    describe "getter" do
      it "is false by default" do
        expect(level.gravity).to eq false
      end
    end

    describe "setter" do
      it "allows to change it to true or false" do
        level.gravity = true
        expect(level.gravity).to eq true

        level.gravity = false
        expect(level.gravity).to eq false
      end
    end
  end

  describe "rows" do
    it "returns number of rows which is always 24" do
      expect(level.rows).to eq 24
    end
  end

  describe "cols" do
    it "returns number of columns which is always 60" do
      expect(level.cols).to eq 60
    end
  end

  describe "name" do
    describe "getter" do
      it "is '------- UNKNOWN -------' by default" do
        expect(level.name).to eq "------- UNKNOWN -------"
      end
    end

    describe "setter" do
      before do
        level.name = "foo"
        level.name = new_name
      end

      context "when new name is exactly 23 bytes long" do
        let(:new_name) { "--------- bar ---------" }

        it "changes name to new one" do
          expect(level.name).to eq new_name
          expect(level.name.size).to eq 23
        end
      end

      context "when new name is less than 23 bytes long" do
        let(:new_name) { "bar" }

        it "changes level name and fill it with spaces up to 23 bytes long" do
          expect(level.name).to eq "bar                    "
          expect(level.name.size).to eq 23
        end
      end

      context "when new name is greater than 23 bytes long" do
        let(:new_name) { "this is spartaaaaaaa!!! #@!%" }

        it "changes name to new one but takes only first 23 bytes" do
          expect(level.name).to eq "this is spartaaaaaaa!!!"
          expect(level.name.size).to eq 23
        end
      end
    end
  end

  describe "fields" do
    it "returns two dimensional array with all fields values" do
      fields = level.fields

      expect(fields).to be_instance_of Array
      expect(fields.size).to eq 24
      expect(fields[0]).to be_instance_of Array
      expect(fields[0].size).to eq 60
    end

    it "is filled with zeros by default" do
      expect(
        level.fields.all? {|row| row.all? {|field| field == 0 } }
      ).to be true
    end
  end

  describe "freeze_zonks attribute" do
    it "is false by default" do
      expect(level.freeze_zonks).to eq false
    end

    it "can be changed to new value (true or false)" do
      level.freeze_zonks = true
      expect(level.freeze_zonks).to eq true

      level.freeze_zonks = false
      expect(level.freeze_zonks).to eq false
    end
  end
end

