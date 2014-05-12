class CallExpression < Expression

  attr_reader :receiver

  def initialize(token, src, receiver: nil)
    @token = token
    @src = src
    @receiver = receiver
  end

  def type
    :call
  end

  def value
    @token.value
  end

  def line
    @token.line
  end

  def column
    @token.column
  end

  def each
    []
  end

end