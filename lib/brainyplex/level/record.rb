module Brainyplex
  module Level

    # References:
    # http://www.elmerproductions.com/sp/filefmt.html
    # http://www.bd-fans.com/Files/FanStuff/Programming/Supaplex_File_Formats.doc
    class DataRecord < ::BinData::Record
      endian  :big
      string  :fields, read_length: 1440
      # 4 bytes, ? [unused]
      skip    length: 4
      uint8   :gravity
      # 1 byte, 20h + SpeedFix_version_hex: v5.4 => 74h; v6.0 => 80h.
      # In the original Supaplex, this value is just 20h.
      skip    length: 1
      string  :title, read_length: 23
      uint8   :freeze_zonks
      uint8   :infotrons_count
      uint8   :special_ports_count
      array   :special_ports, initial_length: 10 do
        uint8   :hi
        uint8   :lo
        uint8   :gravity
        uint8   :freeze_zonks
        uint8   :freeze_enemies
        skip    length: 1
      end
      # 4 bytes, Used by the SpeedFix to store some vital demo information.
      # Unused in the original SUPAPLEX.EXE.
      skip    length: 4
    end

    class MetadataRecord < ::BinData::Record
      endian  :big
      int32   :id
      uint8   :stars_flag
      array   :stars,       type: :int32, initial_length: 3
    end

    class Record < ::BinData::Record
      data_record       :data
      metadata_record   :metadata
    end

  end # Level
end # Brainyplex
