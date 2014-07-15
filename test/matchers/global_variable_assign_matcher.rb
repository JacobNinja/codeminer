class GlobalVariableAssignMatcher < Matcher

  def initialize(name, body_matcher, src)
    @name = name
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :global_variable_assign
  end

  def assert(exp)
    assert_equal @name, exp.value
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end