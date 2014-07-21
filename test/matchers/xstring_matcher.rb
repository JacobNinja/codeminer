class XStringMatcher < Matcher

  def initialize(value, src)
    @value = value
    @src = src
  end

  def type
    :xstring
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @value, exp.value
    assert_equal @src.chomp, exp.src
  end

end