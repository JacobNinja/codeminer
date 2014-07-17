class ParamsMatcher < Matcher

  attr_reader :src

  def initialize(src, positional_matcher, optional_matcher=EmptyParamsMatcher, keyword_matcher=EmptyParamsMatcher, splat: nil, block: nil)
    @positional_matcher = positional_matcher
    @optional_matcher = optional_matcher
    @keyword_matcher = keyword_matcher
    @splat = splat
    @block = block
    @src = src
  end

  def type
    :params
  end

  def assert(exp)
    assert_equal type, exp.type
    @positional_matcher.assert(exp.positional)
    @optional_matcher.assert(exp.optional)
    @keyword_matcher.assert(exp.keyword)
    @splat.assert(exp.splat) if @splat
    @block.assert(exp.block) if @block
    assert_equal @src, exp.src
  end

end