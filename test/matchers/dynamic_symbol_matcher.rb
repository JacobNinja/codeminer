class DynamicSymbolMatcher < Matcher

  def initialize(*body_matchers, src)
    @body_matchers = body_matchers
    @src = src
  end

  def type
    :dynamic_symbol
  end

  def assert(exp)
    assert_equal @body_matchers.length, exp.each.length, "Expected length of body matchers to match length of #{exp.each}"
    @body_matchers.zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src, exp.src
  end

end