class ClassMatcher < Matcher

  def initialize(name, src)
    @name = name
    @src = src
  end

  def type
    :class
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @name, exp.value
    assert_equal @src, exp.src
  end

end