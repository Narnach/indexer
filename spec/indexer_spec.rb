require File.join(File.dirname(__FILE__), 'spec_helper')
require 'indexer'

describe Indexer do
  describe "#store" do
    before(:each) do
      @indexer = Indexer.new
    end

    it "should index stored sentences" do
      @indexer.store(:one =>  "First sentence")
      @indexer.store(:two => "Second sentence")
      @indexer.index.should == {
        "sentence" => Set.new([:one, :two]),
        "first" => Set.new([:one]),
        "second" => Set.new([:two]),
      }
    end

    it "should de-index an overwritten sentence" do
      @indexer.store(:one => "First sentence")
      @indexer.store(:one => "Sentence one")
      @indexer.index.should == {
        "sentence" => Set.new([:one]),
        "one" => Set.new([:one]),
      }
    end
  end
end