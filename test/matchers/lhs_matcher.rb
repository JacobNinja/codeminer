class LhsMatcher < Matcher

  def initialize(*matchers, src)
    @matchers = matchers
    @src = src
  end

  def assert(exp)
    assert_equal @matchers.length, exp.each.length, "Expected body #{exp.each} to equal matchers length"
    @matchers.zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src.chomp, exp.src
  end

end