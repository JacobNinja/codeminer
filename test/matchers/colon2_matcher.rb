class Colon2Matcher < Matcher

  def initialize(value, const_matcher, src)
    @value = value
    @const_matcher = const_matcher
    @src = src
  end

  def type
    :colon2
  end

  def assert(exp)
    assert_equal @value, exp.value
    @const_matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end