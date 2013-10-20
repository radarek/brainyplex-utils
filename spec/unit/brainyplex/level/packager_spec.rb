require 'spec_helper'

describe Brainyplex::Level::Packager do
  it "creates valid package binary from data and metadata files" do
    data      = fixture('level100.sp', :binary)
    metadata  = fixture('level100.json', :binary)
    package   = fixture('level100.bp', :binary)

    FakeFS do
      File.write('level.sp',   data)
      File.write('level.json', metadata)
      packager = Brainyplex::Level::Packager.new
      packager.package_files('level.sp', 'level.json', 'level.bp')

      assert_equal package, File.read('level.bp', encoding: :binary)
    end
  end
end
