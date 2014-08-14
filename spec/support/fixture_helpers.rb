module FixtureHelpers
  def fixture(file_path, format)
    data = File.read(File.expand_path(__dir__ + "/../fixtures/" + file_path))
    case format
      when :binary      then return data
      when :json        then return JSON(data)
      else              raise "Unknown fixture format: #{format}"
    end
  end
end

