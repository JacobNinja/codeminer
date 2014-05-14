class EmptyParamsMatcher < Matcher

  def self.assert(exp)
    assert_empty exp.each, "Expected expression #{exp} to be empty"
  end

end