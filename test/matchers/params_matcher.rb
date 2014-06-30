class ParamsMatcher < Matcher

  attr_reader :src

  def initialize(src, positional_matcher, optional_matcher=EmptyParamsMatcher)
    @positional_matcher = positional_matcher
    @optional_matcher = optional_matcher
    @src = src
  end

  def type
    :params
  end

  def assert(exp)
    @positional_matcher.assert(exp.positional)
    @optional_matcher.assert(exp.optional)
    assert_equal @src, exp.src
  end

end