class RegexpMatcher < Matcher

  def initialize(content, src)
    @content = content
    @src = src
  end

  def type
    :regexp
  end

  def assert(exp)
    assert_equal @content, exp.value
    assert_equal @src.chomp, exp.src
  end

end