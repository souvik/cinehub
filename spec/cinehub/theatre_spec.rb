RSpec.describe Cinehub::Theatre do
  describe "#reserve_seats" do
    it "raises error if no seats available" do
      theatre = Cinehub::Theatre.new(10, 10)
      expect{
        theatre.reserve_seats(1)
      }.to raise_error(Cinehub::UnavailableSeatError, "No seat available!")
    end

    it "reserves seat a3" do
      theatre = Cinehub::Theatre.new(2, 5, {
        b5: { id: 'b5', row: 'b', column: 5, status: 'AVAILABLE' },
        b1: { id: 'b1', row: 'b', column: 1, status: 'AVAILABLE' },
        a2: { id: 'a2', row: 'a', column: 2, status: 'AVAILABLE' },
        b2: { id: 'b2', row: 'b', column: 2, status: 'AVAILABLE' },
        a3: { id: 'a3', row: 'a', column: 3, status: 'AVAILABLE' },
        b3: { id: 'b3', row: 'b', column: 3, status: 'AVAILABLE' },
        a4: { id: 'a4', row: 'a', column: 4, status: 'AVAILABLE' },
        b4: { id: 'b4', row: 'b', column: 4, status: 'AVAILABLE' },
        a5: { id: 'a5', row: 'a', column: 5, status: 'AVAILABLE' },
        a1: { id: 'a1', row: 'a', column: 1, status: 'AVAILABLE' }
      })
      reserved_seat = theatre.reserve_seats(1)
      expect(reserved_seat.map(&:id)).to eq(['a3'])
    end

    it "reserves seat b3 if a3 is unavailable" do
      theatre = Cinehub::Theatre.new(2, 5, {
        b5: { id: 'b5', row: 'b', column: 5, status: 'AVAILABLE' },
        b1: { id: 'b1', row: 'b', column: 1, status: 'AVAILABLE' },
        a2: { id: 'a2', row: 'a', column: 2, status: 'AVAILABLE' },
        b2: { id: 'b2', row: 'b', column: 2, status: 'AVAILABLE' },
        b3: { id: 'b3', row: 'b', column: 3, status: 'AVAILABLE' },
        a4: { id: 'a4', row: 'a', column: 4, status: 'AVAILABLE' },
        b4: { id: 'b4', row: 'b', column: 4, status: 'AVAILABLE' },
        a5: { id: 'a5', row: 'a', column: 5, status: 'AVAILABLE' },
        a1: { id: 'a1', row: 'a', column: 1, status: 'AVAILABLE' }
      })
      reserved_seat = theatre.reserve_seats(1)
      expect(reserved_seat.map(&:id)).to eq(['b3'])
    end

    it "reserves seat from second row if fist row is unavailable" do
      theatre = Cinehub::Theatre.new(2, 5, {
        b5: { id: 'b5', row: 'b', column: 5, status: 'AVAILABLE' },
        b1: { id: 'b1', row: 'b', column: 1, status: 'AVAILABLE' },
        b2: { id: 'b2', row: 'b', column: 2, status: 'AVAILABLE' },
        b3: { id: 'b3', row: 'b', column: 3, status: 'AVAILABLE' },
        b4: { id: 'b4', row: 'b', column: 4, status: 'AVAILABLE' },
        a1: { id: 'a1', row: 'a', column: 1, status: 'AVAILABLE' }
      })
      reserved_seat = theatre.reserve_seats(1)
      expect(reserved_seat.map(&:row)).to eq(['b'])
    end

    it "reserves seat a2 and a3" do
      theatre = Cinehub::Theatre.new(2, 5, {
        b5: { id: 'b5', row: 'b', column: 5, status: 'AVAILABLE' },
        b1: { id: 'b1', row: 'b', column: 1, status: 'AVAILABLE' },
        a2: { id: 'a2', row: 'a', column: 2, status: 'AVAILABLE' },
        b2: { id: 'b2', row: 'b', column: 2, status: 'AVAILABLE' },
        a3: { id: 'a3', row: 'a', column: 3, status: 'AVAILABLE' },
        b3: { id: 'b3', row: 'b', column: 3, status: 'AVAILABLE' },
        a4: { id: 'a4', row: 'a', column: 4, status: 'AVAILABLE' },
        b4: { id: 'b4', row: 'b', column: 4, status: 'AVAILABLE' },
        a5: { id: 'a5', row: 'a', column: 5, status: 'AVAILABLE' },
        a1: { id: 'a1', row: 'a', column: 1, status: 'AVAILABLE' }
      })
      reserved_seats = theatre.reserve_seats(2)
      expect(reserved_seats.map(&:id)).to eq(['a2', 'a3'])
    end

    it "reserves seats a3 and a4" do
      theatre = Cinehub::Theatre.new(2, 5, {
        b5: { id: 'b5', row: 'b', column: 5, status: 'AVAILABLE' },
        b1: { id: 'b1', row: 'b', column: 1, status: 'AVAILABLE' },
        b2: { id: 'b2', row: 'b', column: 2, status: 'AVAILABLE' },
        a3: { id: 'a3', row: 'a', column: 3, status: 'AVAILABLE' },
        b3: { id: 'b3', row: 'b', column: 3, status: 'AVAILABLE' },
        a4: { id: 'a4', row: 'a', column: 4, status: 'AVAILABLE' },
        b4: { id: 'b4', row: 'b', column: 4, status: 'AVAILABLE' },
        a5: { id: 'a5', row: 'a', column: 5, status: 'AVAILABLE' },
        a1: { id: 'a1', row: 'a', column: 1, status: 'AVAILABLE' }
      })
      reserved_seats = theatre.reserve_seats(2)
      expect(reserved_seats.map(&:id)).to eq(['a3', 'a4'])
    end

    it "reserves seats b2 and b3" do
      theatre = Cinehub::Theatre.new(2, 5, {
        b5: { id: 'b5', row: 'b', column: 5, status: 'AVAILABLE' },
        b1: { id: 'b1', row: 'b', column: 1, status: 'AVAILABLE' },
        b2: { id: 'b2', row: 'b', column: 2, status: 'AVAILABLE' },
        a3: { id: 'a3', row: 'a', column: 3, status: 'AVAILABLE' },
        b3: { id: 'b3', row: 'b', column: 3, status: 'AVAILABLE' },
        b4: { id: 'b4', row: 'b', column: 4, status: 'AVAILABLE' },
        a5: { id: 'a5', row: 'a', column: 5, status: 'AVAILABLE' },
        a1: { id: 'a1', row: 'a', column: 1, status: 'AVAILABLE' }
      })
      reserved_seats = theatre.reserve_seats(2)
      expect(reserved_seats.map(&:id)).to eq(['b2', 'b3'])
    end

    it "reserves seats a2, a3 and a4" do
      theatre = Cinehub::Theatre.new(2, 5, {
        b5: { id: 'b5', row: 'b', column: 5, status: 'AVAILABLE' },
        b1: { id: 'b1', row: 'b', column: 1, status: 'AVAILABLE' },
        a2: { id: 'a2', row: 'a', column: 2, status: 'AVAILABLE' },
        b2: { id: 'b2', row: 'b', column: 2, status: 'AVAILABLE' },
        a3: { id: 'a3', row: 'a', column: 3, status: 'AVAILABLE' },
        b3: { id: 'b3', row: 'b', column: 3, status: 'AVAILABLE' },
        a4: { id: 'a4', row: 'a', column: 4, status: 'AVAILABLE' },
        b4: { id: 'b4', row: 'b', column: 4, status: 'AVAILABLE' },
        a5: { id: 'a5', row: 'a', column: 5, status: 'AVAILABLE' },
        a1: { id: 'a1', row: 'a', column: 1, status: 'AVAILABLE' }
      })
      reserved_seats = theatre.reserve_seats(3)
      expect(reserved_seats.map(&:id)).to eq(['a2', 'a3', 'a4'])
    end

    it "fail to reserve seats" do
      theatre = Cinehub::Theatre.new(2, 5, {
        b5: { id: 'b5', row: 'b', column: 5, status: 'AVAILABLE' },
        b1: { id: 'b1', row: 'b', column: 1, status: 'AVAILABLE' },
        a3: { id: 'a3', row: 'a', column: 3, status: 'AVAILABLE' },
        b3: { id: 'b3', row: 'b', column: 3, status: 'AVAILABLE' },
        a5: { id: 'a5', row: 'a', column: 5, status: 'AVAILABLE' },
        a1: { id: 'a1', row: 'a', column: 1, status: 'AVAILABLE' }
      })
      expect{
        theatre.reserve_seats(3)
      }.to raise_error(Cinehub::UnavailableSeatError, "No seat available!")
    end

    it "reserves seats a3, a4, a5 and a6" do
      theatre = Cinehub::Theatre.new(2, 10, {
        b5: { id: 'b5', row: 'b', column: 5, status: 'AVAILABLE' },
        b1: { id: 'b1', row: 'b', column: 1, status: 'AVAILABLE' },
        a2: { id: 'a2', row: 'a', column: 2, status: 'AVAILABLE' },
        b2: { id: 'b2', row: 'b', column: 2, status: 'AVAILABLE' },
        a3: { id: 'a3', row: 'a', column: 3, status: 'AVAILABLE' },
        b3: { id: 'b3', row: 'b', column: 3, status: 'AVAILABLE' },
        a4: { id: 'a4', row: 'a', column: 4, status: 'AVAILABLE' },
        b4: { id: 'b4', row: 'b', column: 4, status: 'AVAILABLE' },
        a5: { id: 'a5', row: 'a', column: 5, status: 'AVAILABLE' },
        a1: { id: 'a1', row: 'a', column: 1, status: 'AVAILABLE' },
        a6: { id: 'a6', row: 'a', column: 6, status: 'AVAILABLE' },
        a7: { id: 'a7', row: 'a', column: 7, status: 'AVAILABLE' },
        a8: { id: 'a8', row: 'a', column: 8, status: 'AVAILABLE' },
        a9: { id: 'a9', row: 'a', column: 9, status: 'AVAILABLE' },
        a10: { id: 'a10', row: 'a', column: 10, status: 'AVAILABLE' },
      })
      reserved_seats = theatre.reserve_seats(4)
      expect(reserved_seats.map(&:id)).to eq(['a3', 'a4', 'a5', 'a6'])
    end
  end
end
