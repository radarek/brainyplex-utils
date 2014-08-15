module Supaplex
  class Level
    attr_reader   :fields, :name, :special_ports
    attr_accessor :gravity, :freeze_zonks, :infotrons_needed

    def initialize
      @fields           = Array.new(24) { Array.new(60, 0) }
      @name             = "------- UNKNOWN -------"
      @gravity          = false
      @freeze_zonks     = false
      @infotrons_needed = 0
      @special_ports    = []
    end

    def rows
      @fields.size
    end

    def cols
      @fields[0].size
    end

    def name=(name)
      @name = name.ljust(23)[0, 23]
    end

    def add_special_port(special_port)
      raise "Number of special ports reached it's limit which is 10!" if @special_ports.size >= 10
      @special_ports.push(special_port)
    end
  end
end

