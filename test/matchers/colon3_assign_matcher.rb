class Colon3AssignMatcher < Matcher

  def initialize(colon3_matcher, body_matcher, src)
    @colon3_matcher = colon3_matcher
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :colon3_assign
  end

  def assert(exp)
    assert_equal type, exp.type
    @colon3_matcher.assert(exp.receiver)
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end