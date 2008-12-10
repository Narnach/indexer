require File.dirname(__FILE__) + '/../../spec_helper'
require 'indexer/core_ext/string'

describe String do
  describe "#tokenize" do
    it 'should split a string by spaces' do
      "this is a string".tokenize.should == %w[this is a string]
    end

    it 'should ignore non-word characters' do
      "hello, world nr. 78!".tokenize.should == %w[hello world nr 78]
    end
    
    it 'should downcase all characters' do
      "I am".tokenize.should == %w[i am]
    end
    
    it 'should ignore duplicates' do
      "To be, or not to be?".tokenize.should == %w[to be or not]
    end
  end
end
