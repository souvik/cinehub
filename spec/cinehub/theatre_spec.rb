RSpec.describe Cinehub::Theatre do
  describe "#reserve_seats" do
    it "raises error if no seats available" do
      theatre = Cinehub::Theatre.new(10, 10)
      expect{
        theatre.reserve_seats(1)
      }.to raise_error(Cinehub::UnavailableSeatError, "No seat available!")
    end
  end
end
