class CommandMatcher < Matcher

  def initialize(value, args_matcher, src, receiver: nil)
    @value = value
    @args_matcher = args_matcher
    @src = src
    @receiver = receiver
  end

  def type
    :command
  end

  def assert(exp)
    assert_equal @value, exp.value
    @args_matcher.assert(exp.args)
    @receiver.assert(exp.receiver) if @receiver
    assert_equal @src, exp.src
  end

end