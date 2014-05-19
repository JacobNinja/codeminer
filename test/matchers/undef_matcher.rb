class UndefMatcher < Matcher

  def initialize(*symbol_matchers, src)
    @symbol_matchers = symbol_matchers
    @src = src
  end

  def type
    :undef
  end

  def assert(exp)
    assert_equal @symbol_matchers.length, exp.each.length
    @symbol_matchers.zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src, exp.src
  end

end