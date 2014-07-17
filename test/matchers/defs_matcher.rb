class DefsMatcher < Matcher

  def initialize(receiver, name, body_matcher, src, params_matcher: nil)
    @receiver = receiver
    @name = name
    @body_matcher = body_matcher
    @src = src
    @params_matcher = params_matcher
  end

  def type
    :defs
  end

  def assert(exp)
    assert_equal type, exp.type
    @receiver.assert(exp.receiver)
    assert_equal @name, exp.value
    @body_matcher.assert(exp.body)
    @params_matcher.assert(exp.params) if @params_matcher
    assert_equal @src.chomp, exp.src
  end

end