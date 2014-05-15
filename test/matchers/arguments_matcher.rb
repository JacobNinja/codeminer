class ArgumentsMatcher < Matcher

  def initialize(*argument_matchers, src)
    @argument_matchers = argument_matchers
    @src = src
  end

  def type
    :arguments
  end

  def assert(exp)
    assert_equal @argument_matchers.length, exp.each.length, "Expected argument matchers length to equal length of #{exp.each}"
    @argument_matchers.zip(exp.each).each do |matcher, e|
      matcher.assert(e)
    end
    assert_equal @src, exp.src
  end

end