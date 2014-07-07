class CallMatcher < Matcher

  def initialize(name, src, receiver: nil, arguments: nil, block: nil)
    @name = name
    @src = src
    @receiver = receiver
    @arguments = arguments
    @block = block
  end

  def type
    :call
  end

  def assert(exp)
    assert_equal type, exp.type
    assert_equal @name, exp.value
    @receiver.assert(exp.receiver) if @receiver
    @arguments.assert(exp.args) if @arguments
    @block.assert(exp.block) if @block
    assert_equal @src.chomp, exp.src
  end

end
