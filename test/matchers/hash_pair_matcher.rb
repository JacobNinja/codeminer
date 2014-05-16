class HashPairMatcher < Matcher

  def initialize(key_matcher, value_matcher, src)
    @key_matcher = key_matcher
    @value_matcher = value_matcher
    @src = src
  end

  def type
    :hash_pair
  end

  def assert(exp)
    @key_matcher.assert(exp.key)
    @value_matcher.assert(exp.value)
    assert_equal @src, exp.src
  end

end