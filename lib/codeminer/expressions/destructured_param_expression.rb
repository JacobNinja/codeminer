class DestructuredParamExpression < Expression

  def initialize(token, src)
    @token = token
    @src = src
  end

  def value
    @token.value
  end

  def type
    :destructured_param
  end

  def each
    []
  end

end