class WhenMatcher < Matcher

  def initialize(body_matcher, consequence_matcher, src)
    @body_matcher = body_matcher
    @consequence_matcher = consequence_matcher
    @src = src
  end

  def type
    :when
  end

  def assert(exp)
    @body_matcher.assert(exp.args)
    @consequence_matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end