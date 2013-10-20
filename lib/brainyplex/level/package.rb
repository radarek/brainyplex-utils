module Brainyplex
  module Level
    class Package
      LEVEL_BYTE_SIZE         = 1553

      attr_reader :binary
      attr_reader :record
      attr_reader :errors

      def initialize(binary)
        @binary = binary
        @record = Record.read(binary)
      end

      def valid?
        @errors = []
        @errors << "binary size should be equal to #{LEVEL_BYTE_SIZE}" if self.binary.bytesize != LEVEL_BYTE_SIZE
        return @errors.empty?
      end

      def level_name
        return @record.data.title
      end

      def metadata
        return @metadata ||= Metadata.from_hash({
          'id'          => @record.metadata.id,
          'stars'       => @record.metadata.stars,
          'stars_flag'  => @record.metadata.stars_flag,
        })
      end

      def self.from_binary(binary)
        return self.new(binary)
      end

      def self.from_data_and_metadata(data, metadata)
        binary = StringIO.new('')
        binary.set_encoding 'binary'
        binary.write(data.binary)

        metadata_record = Brainyplex::Level::MetadataRecord.new({
          id:           metadata.id,
          stars_flag:   metadata.stars.nil? ? 0 : 1,
          stars:        metadata.stars,
        })
        binary.write(metadata_record.to_binary_s)

        return self.from_binary(binary.string)
      end

    end # Package
  end # Level
end # Brainyplex
