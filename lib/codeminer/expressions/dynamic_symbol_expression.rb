class DynamicSymbolExpression < Expression

  def initialize(*body, src)
    @body = body
    @src = src
  end

  def type
    :dynamic_symbol
  end

  def each
    @body
  end

end