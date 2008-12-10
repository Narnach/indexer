require File.join(File.dirname(__FILE__), 'spec_helper')
require 'indexer'

describe Indexer do
  before(:each) do
    @indexer = Indexer.new
  end

  describe "#store" do
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
  
  describe "#score" do
    it "should return all documents which contain the query" do
      @indexer.store(:one =>  "First sentence")
      @indexer.store(:two => "Second sentence")
      @indexer.store(:chance => "Second chance")
      @indexer.score("sentence").should == [:one, :two]
      @indexer.score("second").should == [:chance, :two]
    end
  end
end