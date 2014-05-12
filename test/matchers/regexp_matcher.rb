class RegexpMatcher < Matcher

  def initialize(*content_matchers, src)
    @content_matchers = content_matchers
    @src = src
  end

  def type
    :regexp
  end

  def assert(exp)
    assert_equal @content_matchers.length, exp.each.length, 'Expected body of expression to match count of content matchers'
    @content_matchers.zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src.chomp, exp.src
  end

end