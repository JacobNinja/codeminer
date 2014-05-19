class CallExpression < Expression

  attr_reader :receiver

  def initialize(token, src, receiver: nil, arguments: nil)
    @token = token
    @src = src
    @receiver = receiver
    @args = arguments
  end

  def type
    :call
  end

  def value
    @token.value
  end

  def each
    [@receiver, @args, @block].compact
  end

end