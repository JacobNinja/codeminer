class ConditionalMatcher < Matcher

  def initialize(test_matcher, consequence_matcher, else_statement_matcher, src)
    @test_matcher = test_matcher
    @consequence_matcher = consequence_matcher
    @else_statement_matcher = else_statement_matcher
    @src = src
  end

  def type
    :condition
  end

  def assert(exp)
    @test_matcher.assert(exp.test)
    @consequence_matcher.assert(exp.consequence)
    @else_statement_matcher.assert(exp.else_statement)
    assert_equal @src.chomp, exp.src
  end

end