class PositionalParamExpression < Expression

  def self.convert(exp, src)
    if exp.kind_of?(Token)
      new(exp, src)
    else
      exp
    end
  end

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