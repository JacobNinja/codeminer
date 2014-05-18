class AssignmentMatcher < Matcher

  def initialize(value, body_matcher, src)
    @value = value
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :assign
  end

  def assert(exp)
    assert_equal @value, exp.value
    @body_matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end