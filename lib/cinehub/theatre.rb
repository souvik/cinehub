module Cinehub
  class Theatre
    attr_reader :rows, :columns, :seats

    def initialize(rows, columns, seats={})
      @rows = rows
      @columns = columns
      @seats = compose_seats(seats)
    end

    private
    def compose_seats(seats)
      return seats if seats.empty?
      composed = {}
      seats.each_pair do |id, seat_hsh|
        composed[id] = Seat.new(seat_hsh[:row], seat_hsh[:column], seat_hsh[:status])
      end
      composed
    end
  end
end
