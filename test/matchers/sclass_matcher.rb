class SClassMatcher < Matcher

  def initialize(context_matcher, body_matcher, src)
    @context_matcher = context_matcher
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :sclass
  end

  def assert(exp)
    assert_equal type, exp.type
    @context_matcher.assert(exp.context)
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end