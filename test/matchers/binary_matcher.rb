class BinaryMatcher < Matcher

  def initialize(value, lh_matcher, rh_matcher, src)
    @value = value
    @lh_matcher = lh_matcher
    @rh_matcher = rh_matcher
    @src = src
  end

  def type
    :binary
  end

  def assert(exp)
    assert_equal type, exp.type
    @lh_matcher.assert(exp.left)
    @rh_matcher.assert(exp.right)
    assert_equal @src, exp.src
  end

end