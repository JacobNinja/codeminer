class CommandMatcher < Matcher

  def initialize(value, args_matcher, src)
    @value = value
    @args_matcher = args_matcher
    @src = src
  end

  def type
    :command
  end

  def assert(exp)
    assert_equal @value, exp.value
    @args_matcher.assert(exp.args)
    assert_equal @src, exp.src
  end

end