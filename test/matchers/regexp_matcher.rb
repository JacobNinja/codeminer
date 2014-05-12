class RegexpMatcher < Matcher

  def initialize(content_matcher, src)
    @content_matcher = content_matcher
    @src = src
  end

  def type
    :regexp
  end

  def assert(exp)
    @content_matcher.assert(exp.each.first)
    assert_equal @src.chomp, exp.src
  end

end