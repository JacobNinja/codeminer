class Matcher

  include Test::Unit::Assertions
  extend Test::Unit::Assertions

  attr_reader :type

  def initialize(type, value, src=value)
    @type = type
    @value = value
    @src = src
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @value, exp.value
    assert_equal @src.chomp, exp.src
  end

end