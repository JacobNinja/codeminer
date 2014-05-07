class CallWithBlockMatcher < Matcher

  def initialize(name, block_matcher, src)
    @name = name
    @block_matcher = block_matcher
    @src = src
  end

  def type
    :call
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @name, exp.value
    @block_matcher.assert(exp.block)
    assert_equal @src.chomp, exp.src
  end

end