class ElseMatcher < Matcher

  def initialize(body_matcher, src)
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :else
  end

  def assert(exp)
    assert_equal type, exp.type
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end