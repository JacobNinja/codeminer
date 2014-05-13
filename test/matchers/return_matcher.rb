class ReturnMatcher < Matcher

  def initialize(body_matcher, src)
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :return
  end

  def assert(exp)
    assert_equal type, exp.type
    @body_matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end