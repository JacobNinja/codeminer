class YieldMatcher < Matcher

  def initialize(arguments_matcher, src)
    @arguments_matcher = arguments_matcher
    @src = src
  end

  def type
    :yield
  end

  def assert(exp)
    @arguments_matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end