class AliasMatcher < Matcher

  def initialize(left_matcher, right_matcher, src)
    @left_matcher = left_matcher
    @right_matcher = right_matcher
    @src = src
  end

  def type
    :alias
  end

  def assert(exp)
    @left_matcher.assert(exp.left)
    @right_matcher.assert(exp.right)
    assert_equal @src, exp.src
  end

end