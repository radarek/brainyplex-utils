module Supaplex
  class LevelRecord < ::BinData::Record
    endian :big

    # the level itself (width*height=60*24=1440)
    array :fields, initial_length: 24 do
      array initial_length: 60 do
        uint8
      end
    end

    # 4 bytes, ? [unused]
    skip length: 4

    # gravitation start value (0=off, 1=on)
    uint8 :gravity

    # 20h + SpeedFix_version_hex: v5.4 => 74h; v6.0 => 80h,
    # in the original Supaplex, this value is just 20h
    skip length: 1

    # level title
    string :title, read_length: 23, initial_value: "------- UNKNOWN -------"

    # freeze zonks start value (0=off, 2=on) (yes 2=on, no mistake!)
    uint8 :freeze_zonks

    # number of infotrons needed
    # 0 means Supaplex will count the total number of infotrons in the level at the start and use that
    uint8 :infotrons_needed

    # number of gravity switch ports (maximum 10!)
    uint8 :special_ports_count

    # coordinates of 10 special ports (entries for unused ports are ignored)
    # 6 bytes per port: [hi][lo][grav][fr.zonks][fr.enemy][unused]
    array :special_ports, initial_length: 10 do
      # (2*(x+y*60)) div 256 (integer division) where (x,y) are the coordinates of the special port (0,0=left top)
      uint8 :hi

      # (2*(x+y*60)) mod 256 (remainder of division) where (x,y) are the coordinates of the special port (0,0=left top)
      uint8 :lo

      # 1 (turn on) or 0 (turn off gravity)
      uint8 :gravity

      # 2 (turn on) or 0 (turn off freeze zonks)
      uint8 :freeze_zonks

      # 1 (turn on) or 0 (turn off freeze enemies)
      uint8 :freeze_enemy

      # unused
      skip length: 1
    end

    # used by the SpeedFix to store some vital demo information,
    # unused in the original Supaplex
    skip length: 4
  end
end

