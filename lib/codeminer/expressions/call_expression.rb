class CallExpression < Expression

  attr_reader :block, :args, :token

  def initialize(token, src)
    @token = token
    @src = src
    @block = nil
    @args = nil
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

  def end_column
    @token.column + value.length
  end

  def each
    []
  end

end