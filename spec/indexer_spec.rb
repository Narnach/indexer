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
    before(:each) do
      @indexer.store(:one =>  "First sentence")
      @indexer.store(:two => "Second sentence")
      @indexer.store(:chance => "Second chance")
    end

    it "should return all documents which contain the query" do
      @indexer.score("sentence").should == {1 => Set.new([:one, :two])}
      @indexer.score("second").should == {1 => Set.new([:chance, :two])}
    end

    it "should return a score for each hit" do
      @indexer.score("second sentence").should == {
        1 => Set.new([:one, :chance]),
        2 => Set.new([:two]),
       }
    end
  end
end