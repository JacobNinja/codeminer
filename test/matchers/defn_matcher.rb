class DefnMatcher < Matcher

  def initialize(name, src, params: nil)
    @name = name
    @src = src
    @params_matcher = params
  end

  def type
    :defn
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @name, exp.value
    @params_matcher.assert(exp.params) if @params_matcher
    assert_equal @src.chomp, exp.src
  end

end
