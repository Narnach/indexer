class String
  def tokenize
    self.gsub(/[^\w\s]/,'').downcase.split(" ").uniq
  end
end
