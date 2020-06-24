RSpec.describe Cinehub::Seat do
  it "should have row number" do
    expect(Cinehub::Seat.new('a', 1, true)).to be_respond_to(:row)
  end

  it "should have column number" do
    expect(Cinehub::Seat.new('a', 1, true)).to be_respond_to(:column)
  end

  it "should have availability status" do
    expect(Cinehub::Seat.new('a', 1, true)).to be_respond_to(:available?)
  end
end
