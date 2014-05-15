class RootMatcher < Matcher

  def initialize(*body_matchers, src)
    @body_matchers = body_matchers
    @src = src
  end

  def assert(exp)
    assert_equal :root, exp.type
    @body_matchers.zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src, exp.src
  end

end
