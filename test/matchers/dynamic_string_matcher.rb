class DynamicStringMatcher < Matcher

  def initialize(*body_matchers, src)
    @body_matchers = body_matchers
    @src = src
  end

  def type
    :dynamic_string
  end

  def assert(exp)
    @body_matchers.zip(exp.each).each do |matcher, e|
      assert_not_nil e, "Expected dynamic string to contain expression of type: #{matcher.type}\n#{exp}"
      matcher.assert(e)
    end
    assert_equal @src, exp.src
  end

end