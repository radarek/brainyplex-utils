require 'thor'

module Brainyplex
  module CLI
    def self.start(*args)
      Main.start(*args)
    end

    class Lvl < Thor
      desc 'info PACKAGE_FILE', 'Show info about given level file.'
      def info(file)
        binary = File.read(file, encoding: 'binary')
        package = Brainyplex::Level::Package.from_binary(binary)

        if !package.valid?
          puts 'ERROR: given package file is invalid:'
          puts package.errors.map {|error| " - #{error}" }.join("\n")
          exit(1)
        end

        puts "Package file: #{file}"
        puts "Level name: #{package.level_name}"
        puts "Metadata: #{package.metadata.to_hash}"
      end

      desc 'package DATA_FILE METADATA_FILE', 'Create package file from given data file and metadata file'
      def package(data_file, metadata_file)
        output_file = data_file.sub(/\..*$/, '.bp')

        packager = Brainyplex::Level::Packager.new($stdout)
        packager.package_files(data_file, metadata_file, output_file)
      end
    end

    class Main < Thor
      desc 'lvl SUBCOMMAND ...ARGS', 'manage brainyplex level files'
      subcommand 'lvl', Lvl
    end
  end
end
