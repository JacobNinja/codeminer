class UntilMatcher < Matcher

  def initialize(test_matcher, body_matcher, src)
    @test_matcher = test_matcher
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :until
  end

  def assert(exp)
    @test_matcher.assert(exp.test)
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end