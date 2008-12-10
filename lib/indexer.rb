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
      delete_document(key)
      documents[key] = string
      tokens.each do |token|
        index[token] << key
      end
    end
    nil
  end

  def delete_document(key)
    return unless document = documents.delete(key)
    tokens = document.tokenize
    tokens.each do |token|
      index[token].delete(key)
      index.delete(token) if index[token].size==0
    end
    nil
  end

  def score(query)
    documents = query.tokenize.map { |token|
      index[token].to_a
    }.flatten
    scores = Hash.new { |hash, key| hash[key] = 0 }
    documents.each {|document| scores[document] += 1}
    results = Hash.new { |hash, key| hash[key] = Set.new }
    scores.each {|doc, count| results[count] << doc}
    results
  end
end
