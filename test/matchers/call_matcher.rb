class CallMatcher < Matcher

  def initialize(name, src)
    @name = name
    @src = src
  end

  def type
    :call
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @name, exp.value
    assert_equal @src.chomp, exp.src
  end

end
