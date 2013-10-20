module Brainyplex
  module Level
    class Metadata < ::Hash
      attr_reader :id, :stars
      attr_reader :errors

      def self.from_hash(hash)
        metadata = self.new
        metadata.replace(hash)

        return metadata
      end

      def id
        return self['id']
      end

      def stars
        return self['stars']
      end

      def stars_flag
        return self.stars.nil? ? 0 : 1
      end

      def valid?
        @errors = []
        @errors << 'id is nil' if self.id.nil?
        @errors << 'stars.size != 3' if self.stars && self.stars.size != 3
        return @errors.empty?
      end
    end
  end
end
