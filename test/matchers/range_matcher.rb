class RangeMatcher < Matcher

  def initialize(src, left_matcher, right_matcher, inclusive)
    @left_matcher = left_matcher
    @right_matcher = right_matcher
    @inclusive = inclusive
    @src = src
  end

  def type
    :range
  end

  def assert(exp)
    assert_equal type, exp.type
    @left_matcher.assert(exp.left)
    @right_matcher.assert(exp.right)
    assert_equal @inclusive, exp.inclusive?
    assert_equal @src, exp.src
  end

end