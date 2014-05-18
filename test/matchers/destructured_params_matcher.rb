class DestructuredParamsMatcher < Matcher

  def initialize(*positional_matchers, src)
    @positional_matchers = positional_matchers
    @src = src
  end

  def type
    :destructured_params
  end

  def assert(exp)
    assert_equal @positional_matchers.length, exp.each.length
    @positional_matchers.zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src, exp.src
  end

end