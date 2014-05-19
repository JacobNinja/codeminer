class BeginMatcher < Matcher

  def initialize(src, body_matcher, rescue_matcher: nil)
    @body_matcher = body_matcher
    @rescue_matcher = rescue_matcher
    @src = src
  end

  def type
    :begin
  end

  def assert(exp)
    @body_matcher.assert(exp.body)
    @rescue_matcher.assert(exp.rescue) if @rescue_matcher
    assert_equal @src.chomp, exp.src
  end

end