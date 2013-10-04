class Matcher

  include Test::Unit::Assertions

  attr_reader :type

  def initialize(type, value, src)
    @type = type
    @value = value
    @src = src
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @value, exp.value
    assert_equal @src, exp.src
  end

end