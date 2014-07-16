class Colon2AssignMatcher < Matcher

  def initialize(colon2_matcher, body_matcher, src)
    @colon2_matcher = colon2_matcher
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :colon2_assign
  end

  def assert(exp)
    assert_equal type, exp.type
    @colon2_matcher.assert(exp.receiver)
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end