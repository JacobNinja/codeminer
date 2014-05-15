class ReturnMatcher < Matcher

  def initialize(argument_matcher, src)
    @argument_matcher = argument_matcher
    @src = src
  end

  def type
    :return
  end

  def assert(exp)
    assert_equal type, exp.type
    @argument_matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end