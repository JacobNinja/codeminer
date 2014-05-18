class NextMatcher < Matcher

  def initialize(args_matcher, src)
    @args_matcher = args_matcher
    @src = src
  end

  def type
    :next
  end

  def assert(exp)
    @args_matcher.assert(exp.args)
    assert_equal @src, exp.src
  end

end