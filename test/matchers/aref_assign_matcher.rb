class ArefAssignMatcher < Matcher

  def initialize(receiver_matcher, body_matcher, src)
    @receiver_matcher = receiver_matcher
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :aref_assign
  end

  def assert(exp)
    assert_equal type, exp.type
    @receiver_matcher.assert(exp.receiver)
    @body_matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end