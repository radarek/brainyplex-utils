require "spec_helper"

describe Brainyplex::Level::Package do
  it "creates valid package from valid binary" do
    data      = fixture("level100.bp", :binary)
    package   = Brainyplex::Level::Package.from_binary(data)

    expect(package.level_name).to eq "------- WARM UP -------"
    expect(package.metadata.to_hash).to eq({ "id" => 100, "stars" => [11, 15, 19] })
  end
end

