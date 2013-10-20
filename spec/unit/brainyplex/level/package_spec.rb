require 'spec_helper'

describe Brainyplex::Level::Package do
  it "creates valid package from valid binary" do
    data      = fixture('level100.bp', :binary)
    package   = Brainyplex::Level::Package.from_binary(data)

    assert_equal('------- WARM UP -------', package.level_name)
    assert_equal({ 'id' => 100, 'stars' => [11, 15, 19], 'stars_flag' => 1 }, package.metadata.to_hash)
  end
end
