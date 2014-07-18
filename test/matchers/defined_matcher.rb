class DefinedMatcher < Matcher

  def initialize(matcher, src)
    @matcher = matcher
    @src = src
  end

  def type
    :defined
  end

  def assert(exp)
    assert_equal type, exp.type
    @matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end