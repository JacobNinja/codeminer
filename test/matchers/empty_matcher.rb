class EmptyMatcher < Matcher

  def self.type
    :empty
  end

  def self.assert(exp)
    assert_empty exp.each, "Expected #{exp.each} to be empty"
  end

end