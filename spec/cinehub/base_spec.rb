RSpec.describe Cinehub::Base do
  describe "#create_theatre" do
    it "creates a new theatre" do
      expect(Cinehub::Base.create_theatre(10, 50)).to be_a(Cinehub::Theatre)
    end

    it "creates a theatre with 10 rows" do
      expect(Cinehub::Base.create_theatre(10, 50).rows).to eq(10)
    end

    it "creates a theatre with 50 columns" do
      expect(Cinehub::Base.create_theatre(10, 50).columns).to eq(50)
    end

    it "creates a theatre with seats" do
      expect(Cinehub::Base.create_theatre(10, 50, {
        a2: { id: 'a2', row: 'a', column: 2, status: 'AVAILABLE' },
        a1: { id: 'a1', row: 'a', column: 1, status: 'AVAILABLE' }
      }).seats).to match(a: a_collection_containing_exactly(
        an_instance_of(Cinehub::Seat),
        an_instance_of(Cinehub::Seat)
      ))
    end
  end
end
