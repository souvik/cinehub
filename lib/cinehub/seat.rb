module Cinehub
  class Seat
    attr_reader :row, :column

    def initialize(row, column, status)
      @row = row
      @column = column
      @status = status
    end

    def id
      row + column
    end

    def available?
      @status
    end
  end
end
