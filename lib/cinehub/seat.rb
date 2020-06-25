module Cinehub
  class Seat
    attr_reader :row, :column

    def initialize(row, column, status)
      @row = row
      @column = column
      @status = status
    end

    def id
      row + column.to_s
    end

    def available?
      @status == 'AVAILABLE'
    end

    def reserved?
      @status == 'RESERVED'
    end

    def mark_reserved
      @status = 'RESERVED'
    end
  end
end
