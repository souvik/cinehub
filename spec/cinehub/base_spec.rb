RSpec.describe Cinehub::Base do
  describe "#create_theatre" do
    it "creates a new theatre" do
      expect(Cinehub::Base.create_theatre(10, 50)).to be_a(Cinehub::Theatre)
    end
  end
end
