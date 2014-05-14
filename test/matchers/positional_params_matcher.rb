class PositionalParamsMatcher < Matcher

  def initialize(positionals, src)
    @positionals = positionals
    @src = src
  end

  def type
    :positional_params
  end

  def assert(exp)
    assert_equal @positionals, exp.each.map(&:value)
    assert_equal @src, exp.src
  end

end