class ForMatcher < Matcher

  def initialize(params_matcher, receiver_matcher, body_matcher, src)
    @params_matcher = params_matcher
    @receiver_matcher = receiver_matcher
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :for
  end

  def assert(exp)
    @params_matcher.assert(exp.params)
    @receiver_matcher.assert(exp.receiver)
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end