class ModuleMatcher < Matcher

  def initialize(name, src, body_matcher)
    @name = name
    @src = src
    @body_matcher = body_matcher
  end

  def type
    :module
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @name, exp.value
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end