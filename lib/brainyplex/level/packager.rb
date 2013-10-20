require 'stringio'

module Brainyplex
  module Level
    class Packager
      def initialize(logger = nil)
        @logger = logger
      end

      def package_files(data_file, metadata_file, output_file)
        data = Brainyplex::Level::Data.from_binary(File.read(data_file, encoding: 'binary'))
        metadata = Brainyplex::Level::Metadata.from_hash(JSON.parse(File.read(metadata_file)))

        if !data.valid?
          puts "Data file is invalid: #{data.errors.join(', ')}"
          return nil
        end

        if !metadata.valid?
          puts "Metadata file is invalid: #{metadata.errors.join(', ')}"
          return nil
        end

        puts "Packaging data #{data_file} with metadata #{metadata_file} into #{output_file}"
        File.open(output_file, 'w', encoding: 'binary') do |file|
          package = Brainyplex::Level::Package.from_data_and_metadata(data, metadata)
          file.write(package.binary)
        end

        puts 'Done!'
      end

    private

      def puts(*args)
        @logger.puts(*args) if @logger
      end

    end # Packager
  end # Level
end # Brainyplex
