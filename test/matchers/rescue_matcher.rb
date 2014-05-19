class RescueMatcher < Matcher

  def initialize(src, *body_matchers)
    @src = src
    @body_matchers = body_matchers
  end

  def type
    :rescue
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @body_matchers.length, exp.each.length
    @body_matchers.zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src.chomp, exp.src
  end

end