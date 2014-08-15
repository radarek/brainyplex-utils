module Supaplex
  class Level
    class SpecialPort
      attr_accessor :hi, :lo, :gravity, :freeze_zonks, :freeze_enemy

      def initialize(hi: 0, lo: 0, gravity: false, freeze_zonks: false, freeze_enemy: false)
        self.hi           = hi
        self.lo           = lo
        self.gravity      = gravity
        self.freeze_zonks = freeze_zonks
        self.freeze_enemy = freeze_enemy
      end

      def x
        (256 * hi + lo) / 2 % 60
      end

      def y
        (256 * hi + lo) / 2 / 60
      end
    end
  end
end

