class NilMatcher < Matcher

  def self.assert(exp)
    assert_nil exp, "Expected expression to be nil: #{exp}"
  end

end