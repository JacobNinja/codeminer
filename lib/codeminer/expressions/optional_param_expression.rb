class OptionalParamExpression < Expression

  attr_reader :value

  def initialize(token, value, src)
    @token = token
    @value = value
    @src = src
  end

  def type
    :optional_param
  end

  def variable
    @token.value
  end

  def default
    @value
  end

  def each
    [@token, @value]
  end

end