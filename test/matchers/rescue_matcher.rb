class RescueMatcher < Matcher

  def initialize(src, constant_matchers, variable_matcher, body_matcher)
    @src = src
    @constant_matchers = constant_matchers
    @variable_matcher = variable_matcher
    @body_matcher = body_matcher
  end

  def type
    :rescue
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @constant_matchers.length, exp.constants.length, 'Expected constant length to be equal'
    @constant_matchers.zip(exp.constants).each do |m, e|
      m.assert(e)
    end
    @variable_matcher.assert(exp.variable)
    @body_matcher.assert(exp.body)
    assert_equal @src.chomp, exp.src
  end

end