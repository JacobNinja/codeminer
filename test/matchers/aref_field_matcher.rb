class ArefFieldMatcher < Matcher

  def initialize(value, receiver, arguments, src)
    @value = value
    @receiver = receiver
    @arguments = arguments
    @src = src
  end

  def type
    :aref_field
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @value, exp.value
    @receiver.assert(exp.receiver)
    @arguments.assert(exp.args)
    assert_equal @src.chomp, exp.src
  end

end
