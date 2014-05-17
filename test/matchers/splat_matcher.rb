class SplatMatcher < Matcher

  def initialize(value, src)
    @value = value
    @src = src
  end

  def type
    :splat
  end

  def assert(exp)
    assert_equal @value, exp.value
    assert_equal @src, exp.src
  end

end