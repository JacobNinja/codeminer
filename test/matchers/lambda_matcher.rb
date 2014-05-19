class LambdaMatcher < Matcher

  def initialize(argument_matcher, body_matcher, src)
    @argument_matcher = argument_matcher
    @body_matcher = body_matcher
    @src = src
  end

  def type
    :lambda
  end

  def assert(exp)
    @argument_matcher.assert(exp.args)
    @body_matcher.assert(exp.body)
    assert_equal @src, exp.src
  end

end