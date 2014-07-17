class HashMatcher < Matcher

  def initialize(*pair_matchers, src)
    @pair_matchers = pair_matchers
    @src = src
  end

  def type
    :hash
  end

  def assert(exp)
    assert_equal @pair_matchers.length, exp.pairs.length, 'Expected hash pairs count to match body'
    @pair_matchers.zip(exp.pairs).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src, exp.src
  end

end