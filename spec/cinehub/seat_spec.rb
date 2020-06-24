RSpec.describe Cinehub::Seat do
  it "should have row number" do
    expect(Cinehub::Seat.new('a', 1, 'AVAILABLE')).to be_respond_to(:row)
  end

  it "should have column number" do
    expect(Cinehub::Seat.new('a', 1, 'AVAILABLE')).to be_respond_to(:column)
  end

  it "should have availability status" do
    expect(Cinehub::Seat.new('a', 1, 'AVAILABLE')).to be_respond_to(:available?)
  end

  describe "#available?" do
    it "available if the status is 'AVAILABLE'" do
      expect(Cinehub::Seat.new('a', 1, 'AVAILABLE').available?).to be true
    end

    it "unavailable if the status is not 'AVAILABLE'" do
      expect(Cinehub::Seat.new('a', 1, 'UNAVAILABLE').available?).to be false
    end
  end
end
