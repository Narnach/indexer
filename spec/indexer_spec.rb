require File.join(File.dirname(__FILE__), 'spec_helper')
require 'indexer'

describe Indexer do
  describe ".tokenize" do
    it 'should split a string by spaces' do
      Indexer.tokenize("this is a string").should == %w[this is a string]
    end

    it 'should ignore non-word characters' do
      Indexer.tokenize("hello, world nr. 78!").should == %w[hello world nr 78]
    end
    
    it 'should downcase all characters' do
      Indexer.tokenize("I am").should == %w[i am]
    end
    
    it 'should ignore duplicates' do
      Indexer.tokenize("To be, or not to be?").should == %w[to be or not]
    end
  end
end
