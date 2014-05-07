class DefsMatcher < Matcher

  def initialize(receiver, name, src)
    @receiver = receiver
    @name = name
    @src = src
  end

  def type
    :defs
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @receiver, exp.receiver
    assert_equal @name, exp.value
    assert_equal @src.chomp, exp.src
  end

end