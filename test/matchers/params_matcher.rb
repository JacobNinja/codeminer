class ParamsMatcher < Matcher

  attr_reader :src

  def initialize(src, positional_matcher, optional_matcher=EmptyParamsMatcher, keyword_matcher=EmptyParamsMatcher)
    @positional_matcher = positional_matcher
    @optional_matcher = optional_matcher
    @keyword_matcher = keyword_matcher
    @src = src
  end

  def type
    :params
  end

  def assert(exp)
    @positional_matcher.assert(exp.positional)
    @optional_matcher.assert(exp.optional)
    @keyword_matcher.assert(exp.keyword)
    assert_equal @src, exp.src
  end

end