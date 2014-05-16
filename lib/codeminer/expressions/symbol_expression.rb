class SymbolExpression < Expression

  def initialize(token, src)
    @token = token
    @src = src
  end

  def type
    :symbol
  end

  def value
    @token.value
  end

  def each
    [@token]
  end

end