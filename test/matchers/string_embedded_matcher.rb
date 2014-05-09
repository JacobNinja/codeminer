class StringEmbeddedMatcher < Matcher

  def initialize(*body_matchers, src)
    @body_matchers = body_matchers
    @src = src
  end

  def type
    :string_embexp
  end

  def assert(exp)
    assert_equal @body_matchers.count, exp.each.count, "Expected body matcher count to equal count of children of expression: #{exp}"
    @body_matchers.take(exp.each.count).zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
  end

end