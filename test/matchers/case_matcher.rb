class CaseMatcher < Matcher

  def initialize(src, *body_matchers)
    @src = src
    @body_matchers = body_matchers
  end

  def type
    :case
  end

  def assert(exp)
    assert_equal @body_matchers.length, exp.each.length
    @body_matchers.zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src.chomp, exp.src
  end

end