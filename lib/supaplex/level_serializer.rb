module Supaplex
  class LevelSerializer
    def read_level_from(io)
      record = LevelRecord.read(io)

      return Supaplex::Level.new.tap do |level|
        24.times do |row|
          60.times do |col|
            level.fields[row][col] = record.fields[row][col]
          end
        end

        level.name             = record.title
        level.gravity          = (record.gravity == 1)
        level.infotrons_needed = record.infotrons_needed

        record.special_ports_count.times do |i|
          level.add_special_port(
            special_port_record_to_special_port_object(record.special_ports[i])
          )
        end
      end
    end

    def write_level_to(level, io)
      record = LevelRecord.new.tap do |record|
        24.times do |row|
          60.times do |col|
            record.fields[row][col] = level.fields[row][col]
          end
        end

        record.title               = level.name
        record.gravity             = level.gravity ? 1 : 0
        record.infotrons_needed    = level.infotrons_needed
        record.special_ports_count = level.special_ports.size

        level.special_ports.each_with_index do |special_port, i|
          fill_special_port_struct_from_object(record.special_ports[i], special_port)
        end
      end

      record.write(io)
    end

    private

    def special_port_record_to_special_port_object(record)
      return Level::SpecialPort.new(
        hi:           record.hi,
        lo:           record.lo,
        gravity:      record.gravity == 1,
        freeze_zonks: record.freeze_zonks == 2,
        freeze_enemy: record.freeze_enemy == 1,
      )
    end

    def fill_special_port_struct_from_object(struct, object)
      struct.hi = object.hi
      struct.lo = object.lo
      struct.gravity = object.gravity ? 1 : 0
      struct.freeze_zonks = object.freeze_zonks ? 2 : 0
      struct.freeze_enemy = object.freeze_enemy ? 1 : 0
    end
  end
end

