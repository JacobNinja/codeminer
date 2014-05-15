class IntExpression < Expression

  def initialize(token, src)
    @token = token
    @src = src
  end

  def type
    :int
  end

  def value
    @token.value
  end

end