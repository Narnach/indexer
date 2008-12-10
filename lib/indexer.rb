class Indexer
  def self.tokenize(string)
    string.gsub(/[^\w\s]/,'').downcase.split(" ").uniq
  end
end
