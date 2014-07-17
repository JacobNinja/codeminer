class OpAssignMatcher < Matcher

  def initialize(value, body_matcher, src)
    @value = value
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :op_assign
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @value, exp.variable.value
    @body_matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end