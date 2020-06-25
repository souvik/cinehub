module Cinehub
  class Theatre
    attr_reader :rows, :columns, :seats

    def initialize(rows, columns, seats={})
      @rows = rows
      @columns = columns
      @seats = compose_seats(seats)
    end

    def reserve_seats(num_of_viewer)
      raise UnavailableSeatError.new('No seat available!') if seats.empty?
      selected = nil
      seats.each_pair do |row, row_seats|
        next unless row_seats.size >= num_of_viewer
        column_seats = row_seats.map(&:column)
        mid_seat = columns / 2
        mid_seat = (columns % 2).zero? ? mid_seat : mid_seat + 1
        if column_seats.include?(mid_seat)
          selected = row_seats.find{ |s| s.column == mid_seat }
          selected.mark_reserved
          break
        end
      end
      selected
    end

    private
    def compose_seats(seats)
      return seats if seats.empty?
      composed = {}
      seats.each_pair do |id, seat_hsh|
        seat_hsh.transform_keys!(&:to_sym)
        row_sym = seat_hsh[:row].to_sym
        seat = Seat.new(seat_hsh[:row], seat_hsh[:column], seat_hsh[:status])
        if composed.has_key?(row_sym)
          insert_at = composed[row_sym].bsearch_index{ |s| s.column >= seat.column }
          insert_at.nil? ? composed[row_sym].push(seat) : composed[row_sym].insert(insert_at, seat)
        else
          composed[row_sym] = []
          composed[row_sym] << seat
        end
      end
      Hash[composed.sort]
    end
  end
end
