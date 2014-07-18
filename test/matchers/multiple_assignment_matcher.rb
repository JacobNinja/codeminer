class MultipleAssignmentMatcher < Matcher

  def initialize(src, lhs_matcher, values_matchers)
    @src = src
    @lhs_matcher = lhs_matcher
    @values_matchers = values_matchers
  end

  def type
    :massign
  end

  def assert(exp)
    @lhs_matcher.assert(exp.lhs)
    assert_equal @values_matchers.length, exp.values.each.length
    @values_matchers.zip(exp.values.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src, exp.src
  end

end