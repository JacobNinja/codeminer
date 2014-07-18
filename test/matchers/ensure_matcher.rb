class EnsureMatcher < Matcher

  def initialize(src, body_matcher)
    @src = src
    @body_matcher = body_matcher
  end

  def type
    :ensure
  end

  def assert(exp)
    assert_equal type, exp.type
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end