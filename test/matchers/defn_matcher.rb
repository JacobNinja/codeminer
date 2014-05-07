class DefnMatcher < Matcher

  def initialize(name, src)
    @name = name
    @src = src
  end

  def type
    :defn
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @name, exp.value
    assert_equal @src.chomp, exp.src
  end

end
