class CallMatcher < Matcher

  def initialize(name, src, receiver: nil, arguments: nil)
    @name = name
    @src = src
    @receiver = receiver
    @arguments = arguments
  end

  def type
    :call
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @name, exp.value
    assert_equal @src.chomp, exp.src
    @receiver.assert(exp.receiver) if @receiver
    @arguments.assert(exp.args) if @arguments
  end

end
