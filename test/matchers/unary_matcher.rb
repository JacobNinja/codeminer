class UnaryMatcher < Matcher

  def initialize(value, receiver_matcher, src)
    @value = value
    @receiver_matcher = receiver_matcher
    @src = src
  end

  def type
    :unary
  end

  def assert(exp)
    assert_equal @value, exp.value
    @receiver_matcher.assert(exp.receiver)
    assert_equal @src, exp.src
  end

end