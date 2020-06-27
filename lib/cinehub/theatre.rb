module Cinehub
  module SeatAllocator
    def find_preferable(seats_by_row)
      selected = nil
      column_numbers = seats_by_row.map(&:column)
      mid_seat = columns / 2
      mid_seat = (columns % 2).zero? ? mid_seat : mid_seat + 1
      if column_numbers.include?(mid_seat)
        selected = seats_by_row.find{ |s| s.column == mid_seat }
        #selected.mark_reserved
      end
      selected
    end

    def find_and_mark_by_group(viewers, preferred_seat)
      selected = [ preferred_seat ]
      preferred_row = preferred_seat.row
      preferred_col = preferred_seat.column
      row_seats = seats[preferred_row.to_sym]
      preferred_index = row_seats.index(preferred_seat)
      i = 1
      while selected.size < viewers
        prev_index = preferred_index - i
        if prev_index >= 0
          prev_seat = row_seats[prev_index]
          selected.unshift(prev_seat) if prev_seat.column == (preferred_col - i) && prev_seat.available?
        end

        break if selected.size == viewers

        next_index = preferred_index + i
        if next_index < row_seats.length
          next_seat = row_seats[next_index]
          selected.push(next_seat) if next_seat.column == (preferred_col + i) && next_seat.available?
        end
        break if prev_index < 0 && next_index > row_seats.length
        i += 1
      end
      selected = [] if selected.size != viewers
      selected
    end
  end

  class Theatre
    include SeatAllocator

    attr_reader :rows, :columns, :seats

    def initialize(rows, columns, seats={})
      @rows = rows
      @columns = columns
      @seats = compose_seats(seats)
    end

    def reserve_seats(num_of_viewer)
      raise UnavailableSeatError.new('No seat available!') if seats.empty?
      selected = []
      seats.each_pair do |row, row_seats|
        next unless row_seats.size >= num_of_viewer
        seat = find_preferable(row_seats)
        unless seat.nil?
          selected = find_and_mark_by_group(num_of_viewer, seat)
          next if selected.size != num_of_viewer
          break
        end
      end
      raise UnavailableSeatError.new('No seat available!') if selected.empty?
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
