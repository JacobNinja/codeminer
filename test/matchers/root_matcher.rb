class RootMatcher < Matcher

  def initialize(src)
    @src = src
  end

  def assert(exp)
    assert_equal :root, exp.type
    assert_equal @src, exp.src
  end

end
