class RescueMatcher < Matcher

  def initialize(src, match_matcher, body_matcher)
    @src = src
    @match_matcher = match_matcher
    @body_matcher = body_matcher
  end

  def type
    :rescue
  end

  def assert(exp)
    assert_equal type, exp.type
    @match_matcher.assert(exp.match)
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end