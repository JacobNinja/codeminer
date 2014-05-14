class PositionalParamExpression < Expression

  def initialize(token, src)
    @token = token
    @src = src
  end

  def type
    :positional_param
  end

  def value
    @token.value
  end

  def each
    [@token]
  end

end