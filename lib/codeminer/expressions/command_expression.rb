class CommandExpression < Expression

  attr_reader :args

  def initialize(token, args, src)
    @token = token
    @args = args
    @src = src
  end

  def value
    @token.value
  end

  def type
    :command
  end

  def each
    [@args]
  end

end