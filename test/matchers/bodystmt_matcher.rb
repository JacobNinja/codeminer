class BodystmtMatcher < Matcher

  def initialize(*body_matchers, src)
    @body_matchers = body_matchers
    @src = src
  end

  def type
    :bodystmt
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @body_matchers.length, exp.each.length, "Expected body #{exp.each} to equal matchers length"
    @body_matchers.zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src.chomp, exp.src
  end

end