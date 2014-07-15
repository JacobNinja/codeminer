class AttributeAssignMatcher < Matcher

  def initialize(receiver_matcher, value, body_matcher, src)
    @receiver_matcher = receiver_matcher
    @value = value
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :attribute_assign
  end

  def assert(exp)
    assert_equal type, exp.type
    @receiver_matcher.assert(exp.receiver)
    assert_equal @value, exp.value
    @body_matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end