module Brainyplex
  module Level
    class Data
      LEVEL_BYTE_SIZE = 1536

      attr_accessor :binary
      attr_accessor :errors

      def initialize(binary)
        self.binary = binary
      end

      def self.from_binary(binary)
        return self.new(binary)
      end

      def valid?
        self.errors = []
        self.errors << "binary size should be equal to #{LEVEL_BYTE_SIZE}" if self.binary.bytesize != LEVEL_BYTE_SIZE
        return self.errors.empty?
      end
    end
  end
end
