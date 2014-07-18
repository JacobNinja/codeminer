class RescueMatchMatcher < Matcher

  def initialize(src, *constant_matchers)
    @src = src
    @constant_matchers = constant_matchers
  end

  def type
    :rescue_match
  end

  def assert(exp)
    assert_equal @constant_matchers.length, exp.constants.length, 'Expected body of expression to match count of content matchers'
    @constant_matchers.zip(exp.constants).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src.chomp, exp.src
  end

end