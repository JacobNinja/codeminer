class MultipleAssignmentMatcher < Matcher

  def initialize(src, params_matcher, values_matchers)
    @src = src
    @params_matcher = params_matcher
    @values_matchers = values_matchers
  end

  def type
    :massign
  end

  def assert(exp)
    @params_matcher.assert(exp.params)
    assert_equal @values_matchers.length, exp.values.each.length
    @values_matchers.zip(exp.values.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src, exp.src
  end

end