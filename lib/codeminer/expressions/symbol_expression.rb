class SymbolExpression < Expression

  def self.convert(exp)
    if exp.kind_of?(Token)
      new(exp, exp.src_extract)
    else
      exp
    end
  end

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
    []
  end

end