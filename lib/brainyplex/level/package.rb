module Brainyplex
  module Level
    class Package
      LEVEL_BYTE_SIZE         = 1553
      LEVEL_NAME_OFFSET       = 1446
      LEVEL_NAME_LENGTH       = 23

      attr_accessor :binary
      attr_accessor :errors

      def initialize(binary)
        self.binary = binary
      end

      def valid?
        self.errors = []
        self.errors << "binary size should be equal to #{LEVEL_BYTE_SIZE}" if self.binary.bytesize != LEVEL_BYTE_SIZE
        return self.errors.empty?
      end

      def level_name
        return self.binary[LEVEL_NAME_OFFSET, LEVEL_NAME_LENGTH]
      end

      def self.from_binary(binary)
        return self.new(binary)
      end

      def self.from_data_and_metadata(data, metadata)
        output = StringIO.new('')
        output.set_encoding 'binary'
        output.write(data.binary)
        output.write [metadata.id].pack('L>').force_encoding('binary')

        if metadata.stars
          output.write [1].pack('C')
          output.write metadata.stars.pack('L>*').force_encoding('binary')
        else
          output.write [0].pack('C')
          output.write [0, 0, 0].pack('L>*').force_encoding('binary')
        end

        return self.from_binary(output.string)
      end

    end # Package
  end # Level
end # Brainyplex
