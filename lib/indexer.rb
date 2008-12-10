require 'indexer/core_ext/string'
require 'set'

class Indexer
  attr_reader :index, :documents

  def initialize
    @index = Hash.new { |hash, key| hash[key] = Set.new }
    @documents = {}
  end

  def store(hash)
    hash.each do |key, string|
      tokens = string.tokenize
      if old_document = documents.delete(key)
        old_tokens = old_document.tokenize
        old_tokens.each do |old_token|
          index[old_token].delete(key)
          index.delete(old_token) if index[old_token].size==0
        end
      end
      documents[key] = string
      tokens.each do |token|
        index[token] << key
      end
    end
    nil
  end
end
