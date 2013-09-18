module Brainyplex
  module Level
    class Metadata
      attr_accessor :id, :stars
      attr_accessor :errors

      def self.from_hash(hash)
        metadata = self.new
        metadata.id         = hash["id"]
        metadata.stars      = hash["stars"]

        return metadata
      end

      def valid?
        self.errors = []
        self.errors << 'id is nil' if self.id.nil?
        self.errors << 'stars.size != 3' if self.stars.size != 3
        return self.errors.empty?
      end
    end
  end
end
