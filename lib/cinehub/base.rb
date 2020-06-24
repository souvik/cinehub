module Cinehub
  class Base
    def self.create_theatre(rows, columns, seats=[])
      Theatre.new(rows, columns)
    end
  end
end

